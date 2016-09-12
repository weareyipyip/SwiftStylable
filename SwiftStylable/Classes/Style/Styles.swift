//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


public class Styles {
	
	public static let sharedStyles = Styles()
	
	private var _styles = [String:Style]()
    private var _colors = [String:UIColor]()
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private init() {
        if let helper = STHelper.sharedHelper as? SwiftStylableHelper
        {
            let bundle = NSBundle(forClass: helper.anyProjectClass())
            if let filePath = bundle.pathForResource("styles", ofType: "plist"), data = NSDictionary(contentsOfFile: filePath) as? [String:AnyObject] {
                self.processStyleData(data)
            }
        }
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	public func addStyle(style:Style) {
		if self._styles[style.name] == nil {
			self._styles[style.name] = style
		} else {
			print("A style named: '\(style.name)' already exists!")
		}
	}
	
	public func styleNamed(name:String)->Style? {
		return self._styles[name]
	}
    
    public func colorNamed(name:String)->UIColor? {
        return self._colors[name]
    }
    
    public func processStyleDataWithFileNamed(fileName:String) {
        if let helper = STHelper.sharedHelper as? SwiftStylableHelper
        {
            let bundle = NSBundle(forClass: helper.anyProjectClass())
            if let filePath = bundle.pathForResource(fileName, ofType: "plist"), data = NSDictionary(contentsOfFile: filePath) as? [String:AnyObject] {
                self.processStyleData(data)
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func processStyleData(styleData:[String:AnyObject]) {
        
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
                            styleDatas!.removeValueForKey(name)
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
                        styleDatas!.removeValueForKey(name)
                        numParsedStyles += 1
                    }
                }
            }
            if styleDatas!.count > 0 {
                // Not everything was parsed in the above code, this means there are unsatifyable parent child cycles
                print("WARNING: not all styles could be parsed, this probably means a parent style does not exist, or there are 2 or more styles referring to eachother as a parentStyle.")
            }
        }

    }
}