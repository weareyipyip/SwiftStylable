//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


public class Style {
	public let name:String
	
    // Border style
	public var borderWidth:CGFloat = 0.0
    public var borderStyle = UITextBorderStyle.RoundedRect
	
	// Image tinting
	public var tintImageWithForegroundColor:Bool = false
	
    // Cell separator style
    public var tableViewSeparatorStyle = UITableViewCellSeparatorStyle.SingleLine
	
	// Text
	public var font:UIFont = UIFont.systemFontOfSize(16.0)
	
	// Corners
	public var cornerRadius:CGFloat = 0.0
	
	
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
	public var foregroundColor:UIColor {
		return self.colorWithName(self.foregroundColorName, orDefaultColor: UIColor.darkGrayColor())
	}
	
	public var highlightedForegroundColor:UIColor {
		return self.colorWithName(self.highlightedForegroundColorName, orDefaultColor: UIColor.blackColor())
	}
	
	public var selectedForegroundColor:UIColor {
		return self.colorWithName(self.selectedForegroundColorName, orDefaultColor: UIColor.blueColor())
	}
	
	public var disabledForegroundColor:UIColor {
		return self.colorWithName(self.disabledForegroundColorName, orDefaultColor: UIColor.lightGrayColor())
	}
	
	// Background colors
	public var backgroundColor:UIColor {
		return self.colorWithName(self.backgroundColorName, orDefaultColor: UIColor.whiteColor())
	}
	
	public var highlightedBackgroundColor:UIColor {
		return self.colorWithName(self.highlightedBackgroundColorName, orDefaultColor: UIColor.lightGrayColor())
	}
	
	public var selectedBackgroundColor:UIColor {
		return self.colorWithName(self.selectedBackgroundColorName, orDefaultColor: UIColor.lightGrayColor())
	}
	
	public var disabledBackgroundColor:UIColor {
		return self.colorWithName(self.disabledBackgroundColorName, orDefaultColor: UIColor.whiteColor())
	}
	
	// Border style
	public var borderColor:UIColor {
		return self.colorWithName(self.borderColorName, orDefaultColor: UIColor.clearColor())
	}
	
	public var highlightedBorderColor:UIColor {
		return self.colorWithName(self.highlightedBorderColorName, orDefaultColor: UIColor.clearColor())
	}
	
	public var selectedBorderColor:UIColor {
		return self.colorWithName(self.selectedBorderColorName, orDefaultColor: UIColor.clearColor())
	}
	
	public var disabledBorderColor:UIColor {
		return self.colorWithName(self.disabledBorderColorName, orDefaultColor: UIColor.clearColor())
	}
	
	// Cell separator style
	public var tableViewSeparatorColor:UIColor {
		return self.colorWithName(self.tableViewSeparatorColorName, orDefaultColor: UIColor.lightGrayColor())
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Internal methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	func parseData(data:[String:AnyObject], colors:[String:UIColor]) {
        // Foreground colors
		self.foregroundColorName = data["foregroundColor"] as? String
        self.highlightedForegroundColorName = data["highlightedForegroundColor"] as? String
        self.selectedForegroundColorName = data["selectedForegroundColor"] as? String
        self.disabledForegroundColorName = data["disabledForegroundColor"] as? String
		
        // Foreground colors
        self.backgroundColorName = data["backgroundColor"] as? String
        self.highlightedBackgroundColorName = data["highlightedBackgroundColor"] as? String
        self.selectedBackgroundColorName = data["selectedBackgroundColor"] as? String
        self.disabledBackgroundColorName = data["disabledBackgroundColor"] as? String
		
        // Border style
        if let borderWidth = data["borderWidth"] as? CGFloat {
            self.borderWidth = borderWidth
        }
        self.borderColorName = data["borderColor"] as? String
        self.highlightedBorderColorName = data["highlightedBorderColor"] as? String
        self.selectedBorderColorName = data["selectedBorderColor"] as? String
        self.disabledBorderColorName = data["disabledBorderColor"] as? String
		
        if let borderStyle = data["borderStyle"] as? String {
            switch borderStyle {
            case "None":
                self.borderStyle = .None
                
            case "Line":
                self.borderStyle = .Line
                
            case "Bezel":
                self.borderStyle = .Bezel
                
            case "RoundedRect":
                self.borderStyle = .RoundedRect
                
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
                self.tableViewSeparatorStyle = .None
                
            case "SingleLine":
                self.tableViewSeparatorStyle = .SingleLine
                
            case "SingleLineEtched":
                self.tableViewSeparatorStyle = .SingleLineEtched
                
            default:
                break
            }
        }
        self.tableViewSeparatorColorName = data["tableViewSeparatorColor"] as? String
		
        // Fonts
        if let font = self.parseFont(data: data, key: "font") {
            self.font = font
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

	private func colorWithName(name:String?, orDefaultColor defaultColor:UIColor)->UIColor {
		if let colorName = name, color = Styles.sharedStyles.colorNamed(colorName) {
			return color
		} else {
			return defaultColor
		}
	}
	
    private func parseFont(data data:[String:AnyObject], key:String)->UIFont? {
		if let fontData = data[key] as? [String:AnyObject] {
			let name = fontData["name"] as? String ?? self.font.fontName
			let size = fontData["size"] as? CGFloat ?? self.font.pointSize
            return UIFont(name: name, size: size)
        } else {
            return nil
        }
    }
}