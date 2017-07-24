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
    
    open static let shared = Styles()
    
    private var _styles = [String:Style]()
    private var _colors = [String:UIColor]()
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private init() {
        var data:[String:AnyObject]?
        
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
        return self._colors[name]
    }
    
    open func imageNamed(_ name:String)->UIImage? {
        var image:UIImage?
        
        if let helper = STHelper.sharedHelper as? SwiftStylableHelper {
            image = helper.imageNamed(name)
        }
        return image
    }
    
    open func processStyleDataWithFileNamed(_ fileName:String) {
        self.processStyleDataWithFileNamed(fileName, publishUpdate: true)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func pathForStylesDescriptorNamed(_ name:String)->String? {
        var filePath:String?
        if let interfaceBuilderProjectResourcePaths = ProcessInfo.processInfo.environment["IB_PROJECT_SOURCE_DIRECTORIES"] {
            let url = URL(fileURLWithPath: interfaceBuilderProjectResourcePaths)
            filePath = url.deletingLastPathComponent().appendingPathComponent(name + ".plist").path
        } else {
            filePath = Bundle.main.path(forResource: name, ofType: "plist")
        }
        return filePath
    }
    
    private func processStyleDataWithFileNamed(_ name:String, publishUpdate:Bool) {
        
        guard let stylesFilePath = self.pathForStylesDescriptorNamed("styles"),
            let styleData = NSDictionary(contentsOfFile: stylesFilePath) as? [String:AnyObject] else {
                return
        }
        
        // Parse color strings
        if let colorEntries = styleData["colors"] as? [String:String] {
            for (name, colorString) in colorEntries {
                self._colors[name] = UIColor(hexString: colorString)
            }
        }
        
        var styleDatas = styleData["styles"] as? [String:[String:AnyObject]]
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
                            let style = Style(name: name, parentStyle: parentStyle, overridesData: styleData, colors: self._colors)
                            self._styles[name] = style
                            styleDatas!.removeValue(forKey: name)
                            numParsedStyles += 1
                        }
                    } else {
                        if style == nil {
                            // Create a new style with the data
                            style = Style(name: name, data: styleData, colors: self._colors)
                        } else {
                            style!.parseData(styleData, colors: self._colors)
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
