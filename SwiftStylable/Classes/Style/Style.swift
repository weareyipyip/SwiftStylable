//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


open class Style {
	open let name:String
	
    // Border style
	open var borderWidth:CGFloat = 0.0
    open var borderStyle = UITextBorderStyle.roundedRect
	
	// Image tinting
	open var tintImageWithForegroundColor:Bool = false
	
    // Cell separator style
    open var tableViewSeparatorStyle = UITableViewCellSeparatorStyle.singleLine
	
	// Text
	open var font:UIFont = UIFont.systemFont(ofSize: 16.0)
	open var fullUppercaseText = false
	

	// Corners
	open var cornerRadius:CGFloat = 0.0
	
	
	// Foreground color names
	private (set) var foregroundColorName:String?
	private (set) var highlightedForegroundColorName:String?
	private (set) var selectedForegroundColorName:String?
	private (set) var disabledForegroundColorName:String?
	
	// Background color names
	private (set) var backgroundColorName:String?
	private (set) var highlightedBackgroundColorName:String?
	private (set) var selectedBackgroundColorName:String?
	private (set) var disabledBackgroundColorName:String?
	
	// Border color names
	private (set) var borderColorName:String?
	private (set) var highlightedBorderColorName:String?
	private (set) var selectedBorderColorName:String?
	private (set) var disabledBorderColorName:String?
	
	// Cell style color names
	private (set) var tableViewSeparatorColorName:String?
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	public init(name:String) {
		self.name = name
	}
    
    public init(name:String, data:[String:AnyObject], colors:[String:UIColor]) {
        self.name = name
        self.parseData(data, colors: colors)
    }
    
    public init(name:String, parentStyle:Style, overridesData:[String:AnyObject], colors:[String:UIColor]) {
        self.name = name
     
        // Set properties from parent
        
        // - foreground colors
        self.foregroundColorName = parentStyle.foregroundColorName
        self.highlightedForegroundColorName = parentStyle.highlightedForegroundColorName
        self.selectedForegroundColorName = parentStyle.selectedForegroundColorName
        self.disabledForegroundColorName = parentStyle.disabledForegroundColorName
        
        // - background colors
        self.backgroundColorName = parentStyle.backgroundColorName
        self.highlightedBackgroundColorName = parentStyle.highlightedBackgroundColorName
        self.selectedBackgroundColorName = parentStyle.selectedBackgroundColorName
        self.disabledBackgroundColorName = parentStyle.disabledBackgroundColorName
        
        // - border style
        self.borderWidth = parentStyle.borderWidth
        self.borderColorName = parentStyle.borderColorName
        self.highlightedBorderColorName = parentStyle.highlightedBorderColorName
        self.selectedBorderColorName = parentStyle.selectedBorderColorName
        self.disabledBorderColorName = parentStyle.disabledBorderColorName
        self.borderStyle = parentStyle.borderStyle
        
		
		// - image tinting
		self.tintImageWithForegroundColor = parentStyle.tintImageWithForegroundColor
        
        // - cell separator style
        self.tableViewSeparatorStyle = parentStyle.tableViewSeparatorStyle
        self.tableViewSeparatorColorName = parentStyle.tableViewSeparatorColorName
        
        // - font
        self.font = parentStyle.font
		
		// - text
		self.fullUppercaseText = parentStyle.fullUppercaseText
        
        // - other
        self.cornerRadius = parentStyle.cornerRadius
        
        
        // Set overrides
        self.parseData(overridesData, colors: colors)
    }
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Computed properties
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	// Foreground colors
	open var foregroundColor:UIColor {
		return self.colorWithName(self.foregroundColorName, orDefaultColor: UIColor.black)
	}
	
	open var highlightedForegroundColor:UIColor {
		return self.colorWithName(self.highlightedForegroundColorName, orDefaultColor: self.foregroundColor)
	}
	
	open var selectedForegroundColor:UIColor {
		return self.colorWithName(self.selectedForegroundColorName, orDefaultColor: self.foregroundColor)
	}
	
	open var disabledForegroundColor:UIColor {
		return self.colorWithName(self.disabledForegroundColorName, orDefaultColor: self.foregroundColor)
	}
	
	// Background colors
	open var backgroundColor:UIColor {
		return self.colorWithName(self.backgroundColorName, orDefaultColor: UIColor.white)
	}
	
	open var highlightedBackgroundColor:UIColor {
		return self.colorWithName(self.highlightedBackgroundColorName, orDefaultColor: self.backgroundColor)
	}
	
	open var selectedBackgroundColor:UIColor {
		return self.colorWithName(self.selectedBackgroundColorName, orDefaultColor: self.backgroundColor)
	}
	
	open var disabledBackgroundColor:UIColor {
		return self.colorWithName(self.disabledBackgroundColorName, orDefaultColor: self.backgroundColor)
	}
	
	// Border style
	open var borderColor:UIColor {
		return self.colorWithName(self.borderColorName, orDefaultColor: UIColor.clear)
	}
	
	open var highlightedBorderColor:UIColor {
		return self.colorWithName(self.highlightedBorderColorName, orDefaultColor: self.borderColor)
	}
	
	open var selectedBorderColor:UIColor {
		return self.colorWithName(self.selectedBorderColorName, orDefaultColor: self.borderColor)
	}
	
	open var disabledBorderColor:UIColor {
		return self.colorWithName(self.disabledBorderColorName, orDefaultColor: self.borderColor)
	}
	
	// Cell separator style
	open var tableViewSeparatorColor:UIColor {
		return self.colorWithName(self.tableViewSeparatorColorName, orDefaultColor: UIColor.lightGray)
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Internal methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	func parseData(_ data:[String:AnyObject], colors:[String:UIColor]) {
        // Foreground colors
		if let foregroundColorName = data["foregroundColor"] as? String {
			self.foregroundColorName = foregroundColorName
		}
		if let highlightedForegroundColorName = data["highlightedForegroundColor"] as? String {
			self.highlightedForegroundColorName = highlightedForegroundColorName
		}
		if let selectedForegroundColorName = data["selectedForegroundColor"] as? String {
			self.selectedForegroundColorName = selectedForegroundColorName
		}
		if let disabledForegroundColorName = data["disabledForegroundColor"] as? String {
			self.disabledForegroundColorName = disabledForegroundColorName
		}
		
        // Background colors
		if let backgroundColorName = data["backgroundColor"] as? String {
			self.backgroundColorName = backgroundColorName
		}
		if let highlightedBackgroundColorName = data["highlightedBackgroundColor"] as? String {
			self.highlightedBackgroundColorName = highlightedBackgroundColorName
		}
		if let selectedBackgroundColorName = data["selectedBackgroundColor"] as? String {
			self.selectedBackgroundColorName = selectedBackgroundColorName
		}
		if let disabledBackgroundColorName = data["disabledBackgroundColor"] as? String {
			self.disabledBackgroundColorName = disabledBackgroundColorName
		}
		
        // Border style
        if let borderWidth = data["borderWidth"] as? CGFloat {
            self.borderWidth = borderWidth
        }
		if let borderColorName = data["borderColor"] as? String {
			self.borderColorName = borderColorName
		}
		if let highlightedBorderColorName = data["highlightedBorderColor"] as? String {
			self.highlightedBorderColorName = highlightedBorderColorName
		}
		if let selectedBorderColorName = data["selectedBorderColor"] as? String {
			self.selectedBorderColorName = selectedBorderColorName
		}
		if let disabledBorderColorName = data["disabledBorderColor"] as? String {
			self.disabledBorderColorName = disabledBorderColorName
		}
		
        if let borderStyle = data["borderStyle"] as? String {
            switch borderStyle {
            case "None":
                self.borderStyle = .none
                
            case "Line":
                self.borderStyle = .line
                
            case "Bezel":
                self.borderStyle = .bezel
                
            case "RoundedRect":
                self.borderStyle = .roundedRect
                
            default:
                break
                
            }
        }
        
        // Image tinting
        if let tintImageWithForegroundColor = data["tintImageWithForegroundColor"] as? Bool {
            self.tintImageWithForegroundColor = tintImageWithForegroundColor
        }
        
        // TableView style
        if let tableViewSeparatorStyleString = data["tableViewSeparatorStyle"] as? String {
            switch tableViewSeparatorStyleString {
            case "None":
                self.tableViewSeparatorStyle = .none
                
            case "SingleLine":
                self.tableViewSeparatorStyle = .singleLine
                
            case "SingleLineEtched":
                self.tableViewSeparatorStyle = .singleLineEtched
                
            default:
                break
            }
        }
		if let tableViewSeparatorColorName = data["tableViewSeparatorColor"] as? String {
			self.tableViewSeparatorColorName = tableViewSeparatorColorName
		}
		
        // Fonts
        if let font = self.parseFont(data: data, key: "font") {
            self.font = font
        }
		
		// Text
		if let fullUppercaseText = data["fullUppercaseText"] as? Bool {
			self.fullUppercaseText = fullUppercaseText
		}
        
        // CornerRadius
        if let cornerRadius = data["cornerRadius"] as? CGFloat {
            self.cornerRadius = cornerRadius
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------

	fileprivate func colorWithName(_ name:String?, orDefaultColor defaultColor:UIColor)->UIColor {
		if let colorName = name, let color = Styles.sharedStyles.colorNamed(colorName) {
			return color
		} else {
			return defaultColor
		}
	}
	
    fileprivate func parseFont(data:[String:AnyObject], key:String)->UIFont? {
		if let fontData = data[key] as? [String:AnyObject] {
			let name = fontData["name"] as? String ?? self.font.fontName
			let size = fontData["size"] as? CGFloat ?? self.font.pointSize
			switch name {
			case "systemFont":
				return UIFont.systemFont(ofSize: size)
				
			case "boldSystemFont":
				return UIFont.boldSystemFont(ofSize: size)
				
			case "italicSystemFont":
				return UIFont.italicSystemFont(ofSize: size)
				
			case "thinSystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightThin)
				
			case "blackSystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightBlack)
				
			case "heavySystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightHeavy)
				
			case "lightSystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightLight)
				
			case "mediumSystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
				
			case "semiboldSystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightSemibold)
				
			case "ultraLightSystemFont":
				return UIFont.systemFont(ofSize: size, weight: UIFontWeightUltraLight)
				
			default:
				return UIFont(name: name, size: size)
			}
        } else {
            return nil
        }
    }
}
