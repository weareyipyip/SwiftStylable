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
	
	// Foreground colors
	public var foregroundColor = UIColor.darkGrayColor()
	public var highlightedForegroundColor = UIColor.blackColor()
	public var selectedForegroundColor = UIColor.blueColor()
	public var disabledForegroundColor = UIColor.lightGrayColor()
	
    // Background colors
	public var backgroundColor = UIColor.whiteColor()
	public var highlightedBackgroundColor = UIColor.lightGrayColor()
	public var selectedBackgroundColor = UIColor.lightGrayColor()
	public var disabledBackgroundColor = UIColor.whiteColor()
	
    // Border style
	public var borderWidth:CGFloat = 0.0
	public var borderColor = UIColor.clearColor()
	public var highlightedBorderColor = UIColor.clearColor()
	public var selectedBorderColor = UIColor.clearColor()
	public var disabledBorderColor = UIColor.clearColor()
    public var borderStyle = UITextBorderStyle.RoundedRect
    
	// Image tinting
	public var tintImageWithForegroundColor:Bool = false
	
    // Cell separator style
    public var tableViewSeparatorStyle = UITableViewCellSeparatorStyle.SingleLine
    public var tableViewSeparatorColor = UIColor.lightGrayColor()
	
	public var font:UIFont = UIFont.systemFontOfSize(16.0)
	
	public var cornerRadius:CGFloat = 0.0
	
	
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
        self.foregroundColor = parentStyle.foregroundColor
        self.highlightedForegroundColor = parentStyle.highlightedForegroundColor
        self.selectedForegroundColor = parentStyle.selectedForegroundColor
        self.disabledForegroundColor = parentStyle.disabledForegroundColor
        
        // - background colors
        self.backgroundColor = parentStyle.backgroundColor
        self.highlightedBackgroundColor = parentStyle.highlightedBackgroundColor
        self.selectedBackgroundColor = parentStyle.selectedBackgroundColor
        self.disabledBackgroundColor = parentStyle.disabledBackgroundColor
        
        // - border style
        self.borderWidth = parentStyle.borderWidth
        self.borderColor = parentStyle.borderColor
        self.highlightedBorderColor = parentStyle.highlightedBorderColor
        self.selectedBorderColor = parentStyle.selectedBorderColor
        self.disabledBorderColor = parentStyle.disabledBorderColor
        self.borderStyle = parentStyle.borderStyle
        
		
		// - image tinting
		self.tintImageWithForegroundColor = parentStyle.tintImageWithForegroundColor
        
        // - cell separator style
        self.tableViewSeparatorStyle = parentStyle.tableViewSeparatorStyle
        self.tableViewSeparatorColor = parentStyle.tableViewSeparatorColor
        
        // - font
        self.font = parentStyle.font
        
        // - other
        self.cornerRadius = parentStyle.cornerRadius
        
        
        // Set overrides
        self.parseData(overridesData, colors: colors)
    }
    
    func parseData(data:[String:AnyObject], colors:[String:UIColor]) {
        // Foreground colors
        if let foregroundColor = self.parseColor(data: data, key: "foregroundColor", colors: colors) {
            self.foregroundColor = foregroundColor
        }
        if let highlightedForegroundColor = self.parseColor(data: data, key: "highlightedForegroundColor", colors: colors) {
            self.highlightedForegroundColor = highlightedForegroundColor
        }
        if let selectedForegroundColor = self.parseColor(data: data, key: "selectedForegroundColor", colors: colors) {
            self.selectedForegroundColor = selectedForegroundColor
        }
        if let disabledForegroundColor = self.parseColor(data: data, key: "disabledForegroundColor", colors: colors) {
            self.disabledForegroundColor = disabledForegroundColor
        }
        
        // Foreground colors
        if let backgroundColor = self.parseColor(data: data, key: "backgroundColor", colors: colors) {
            self.backgroundColor = backgroundColor
        }
        if let highlightedBackgroundColor = self.parseColor(data: data, key: "highlightedBackgroundColor", colors: colors) {
            self.highlightedBackgroundColor = highlightedBackgroundColor
        }
        if let selectedBackgroundColor = self.parseColor(data: data, key: "selectedBackgroundColor", colors: colors) {
            self.selectedBackgroundColor = selectedBackgroundColor
        }
        if let disabledBackgroundColor = self.parseColor(data: data, key: "disabledBackgroundColor", colors: colors) {
            self.disabledBackgroundColor = disabledBackgroundColor
        }
        
        // Border style
        if let borderWidth = data["borderWidth"] as? CGFloat {
            self.borderWidth = borderWidth
        }
        if let borderColor = self.parseColor(data: data, key: "borderColor", colors: colors) {
            self.borderColor = borderColor
        }
        if let highlightedBorderColor = self.parseColor(data: data, key: "highlightedBorderColor", colors: colors) {
            self.highlightedBorderColor = highlightedBorderColor
        }
        if let selectedBorderColor = self.parseColor(data: data, key: "selectedBorderColor", colors: colors) {
            self.selectedBorderColor = selectedBorderColor
        }
        if let disabledBorderColor = self.parseColor(data: data, key: "disabledBorderColor", colors: colors) {
            self.disabledBorderColor = disabledBorderColor
        }
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
        if let tableViewSeparatorColor = self.parseColor(data: data, key: "tableViewSeparatorColor", colors: colors) {
            self.tableViewSeparatorColor = tableViewSeparatorColor
        }
        
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
    
    private func parseColor(data data:[String:AnyObject], key:String, colors:[String:UIColor])->UIColor? {
        if let colorName = data[key] as? String {
            if let color = colors[colorName] {
                return color
            } else {
                return UIColor(hexString: colorName)
            }
        } else {
            return nil
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