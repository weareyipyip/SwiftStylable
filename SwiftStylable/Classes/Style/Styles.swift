//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


internal let STYLES_DID_UPDATE = Notification.Name(rawValue: "stylesDidUpdate")


open class Styles {
    
    public static let shared = Styles()
    
    private var _styles = [String:Style]()
    private let _colorCollection = ColorCollection()
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private init() {
        self.processStyleDataWithFileNamed("styles", publishUpdate: false)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func addStyle(_ style:Style) {
        if self._styles[style.name] == nil {
            self._styles[style.name] = style
        } else {
            print("A style named: '\(style.name)' already exists!")
        }
    }
    
    open func styleNamed(_ name:String)->Style? {
        return self._styles[name]
    }
    
    open func colorNamed(_ name:String)->UIColor? {
        return self._colorCollection.colorHolderNamed(name)?.color
    }
        
    open func processStyleDataWithFileNamed(_ fileName:String) {
		self.processStyleDataWithFileNamed(fileName, publishUpdate: true)
    }
	
	open func processStyleDataWithFileAtPath(_ path:String) {
		self.processStyleDataWithFileAtPath(path, publishUpdate: true)
	}
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func pathForStylesDescriptorNamed(_ name:String)->String? {
        var filePath:String?
        if let interfaceBuilderProjectResourcePaths = ProcessInfo.processInfo.environment["IB_PROJECT_SOURCE_DIRECTORIES"]?.components(separatedBy: ":") {
            for path in interfaceBuilderProjectResourcePaths {
                let url = URL(fileURLWithPath: path)
                if url.lastPathComponent == "Pods" {
                    filePath = url.deletingLastPathComponent().appendingPathComponent(name + ".plist").path
                }
            }
        } else {
            filePath = Bundle.main.path(forResource: name, ofType: "plist")
        }
        return filePath
    }
	
	private func processStyleDataWithFileNamed(_ fileName:String, publishUpdate:Bool) {
		if let stylesFilePath = self.pathForStylesDescriptorNamed(fileName) {
			self.processStyleDataWithFileAtPath(stylesFilePath, publishUpdate: publishUpdate)
		}
	}
	
	private func processStyleDataWithFileAtPath(_ path:String, publishUpdate:Bool) {
		
        guard let styleData = NSDictionary(contentsOfFile: path) as? [String:Any] else {
                return
        }
        
        // Parse color strings
        if let colorData = styleData["colors"] as? [String:String] {
            self._colorCollection.applyData(colorData)
            
            // Force update all styles, to make them process the new color information
            for keyValuePair in self._styles {
                keyValuePair.value.update()
            }
        }
        
        var styleDatas = styleData["styles"] as? [String:[String:Any]]
        if styleDatas != nil {
            
            // Read styles
            var numParsedStyles = 1
            while styleDatas!.count > 0 && numParsedStyles > 0 {
                let styleDatasCopy = styleDatas!
                numParsedStyles = 0
                for (name, styleData) in styleDatasCopy {
                    var style = self._styles[name]
                    if let parentName = styleData["parent"] as? String {
                        if let parentStyle = self._styles[parentName] {
                            if style != nil {
                                print("WARNING: You cannot override the parent property of a style! Style named '\(name)' will be replaced completely.")
                            }
                            let style = Style(name: name, parent: parentStyle, data: styleData, colorCollection: self._colorCollection)
                            self._styles[name] = style
                            styleDatas!.removeValue(forKey: name)
                            numParsedStyles += 1
                        }
                    } else {
                        if style == nil {
                            // Create a new style with the data
                            style = Style(name: name, data: styleData, colorCollection: self._colorCollection)
                        } else {
                            style!.parseData(styleData)
                        }
                        self._styles[name] = style!
                        styleDatas!.removeValue(forKey: name)
                        numParsedStyles += 1
                    }
                }
            }
            if styleDatas!.count > 0 {
                // Not everything was parsed in the above code, this means there are unsatifyable parent child cycles
                print("WARNING: not all styles could be parsed, this probably means a parent style does not exist, or there are 2 or more styles referring to eachother as a parentStyle.")
            }
        }
        
        if publishUpdate {
            NotificationCenter.default.post(name: STYLES_DID_UPDATE, object: self)
        }
    }
}
