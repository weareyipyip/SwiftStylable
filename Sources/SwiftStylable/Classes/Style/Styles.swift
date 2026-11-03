//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import UIKit


internal let STYLES_DID_UPDATE = Notification.Name(rawValue: "stylesDidUpdate")


open class Styles {
    
    public static let shared = Styles()
    
    private var _styles = [String:Style]()
    private let _colorCollection = ColorCollection()
    private let _dimensionCollection = DimensionCollection()
    
    
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
    
    open func dimensionNamed(_ name:String)->CGFloat? {
        return self._dimensionCollection.dimensionHolderNamed(name)?.size
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
        if let interfaceBuilderProjectResourcePaths = ProcessInfo.processInfo.environment["IB_PROJECT_SOURCE_DIRECTORIES"]?.components(separatedBy: ":") {
            // The styles file sits next to the Xcode project, which is either one of the source directories
            // itself or the parent of one (e.g. the Pods directory when installed through CocoaPods)
            let directories = interfaceBuilderProjectResourcePaths.map { URL(fileURLWithPath: $0) }
            let candidates = directories + directories.map { $0.deletingLastPathComponent() }
            for directory in candidates {
                let filePath = directory.appendingPathComponent(name + ".plist").path
                if FileManager.default.fileExists(atPath: filePath) {
                    return filePath
                }
            }
        }
        return Bundle.main.path(forResource: name, ofType: "plist")
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
		}
        
        // Parse dimensions strings
        if let dimensionData = styleData["dimensions"] as? [String:Any] {
            self._dimensionCollection.applyData(dimensionData)
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
                            
                            // WARNING: You cannot override the parent property of a style! Style will be replaced completely.
                            let style = Style(name: name, parent: parentStyle, data: styleData, colorCollection: self._colorCollection, dimensionCollection: self._dimensionCollection)
                            self._styles[name] = style
                            styleDatas!.removeValue(forKey: name)
                            numParsedStyles += 1
                        }
                    } else {
                        if style == nil {
                            
                            // Create a new style with the data
                            style = Style(name: name, data: styleData, colorCollection: self._colorCollection, dimensionCollection: self._dimensionCollection)
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
		
		// Update all styles
		for keyValuePair in self._styles {
			keyValuePair.value.update()
		}
		
        if publishUpdate {
            NotificationCenter.default.post(name: STYLES_DID_UPDATE, object: self)
        }
    }
}
