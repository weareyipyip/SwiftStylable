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
                var styleDatas = data["styles"] as? [String:[String:AnyObject]]
                
                if styleDatas != nil {
                    
                    // Read color strings
                    let colorStrings:[String:String]
                    if let colorEntries = data["colors"] as? [String:String] {
                        colorStrings = colorEntries
                    } else {
                        colorStrings = [String:String]()
                    }
                    
                    // Read styles
                    var numParsedStyles = 1
                    while styleDatas!.count > 0 && numParsedStyles > 0 {
                        let styleDatasCopy = styleDatas!
                        numParsedStyles = 0
                        for (name, styleData) in styleDatasCopy {
                            if let parentName = styleData["parent"] as? String {
                                if let parentStyle = self._styles[parentName] {
                                    let style = Style(name: name, parentStyle: parentStyle, overridesData: styleData, colorStrings: colorStrings)
                                    self._styles[name] = style
                                    styleDatas!.removeValueForKey(name)
                                    numParsedStyles += 1
                                }
                            } else {
                                let style = Style(name: name, data: styleData, colorStrings: colorStrings)
                                self._styles[name] = style
                                styleDatas!.removeValueForKey(name)
                                numParsedStyles += 1
                            }
                        }
                    }
                    if styleDatas!.count > 0 {
                        // Not everything was parsed in the above code, this means there are unsatifyable parent child cycles
                        print("WARNING: not all styles could be parsed, this probably means there are 2 or more styles referring to eachother as a parentStyle.")
                    }
                }
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
}