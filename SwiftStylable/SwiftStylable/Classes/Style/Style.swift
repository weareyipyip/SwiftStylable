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
    
    public init(data:[String:AnyObject], colorStrings:[String:String]) {
        self.name = data["name"] as! String
        
        // Foreground colors
        if let foregroundColor = self.parseColor(data: data, key: "foregroundColor", colorStrings: colorStrings) {
            self.foregroundColor = foregroundColor
        }
        if let highlightedForegroundColor = self.parseColor(data: data, key: "highlightedForegroundColor", colorStrings: colorStrings) {
            self.highlightedForegroundColor = highlightedForegroundColor
        }
        if let selectedForegroundColor = self.parseColor(data: data, key: "selectedForegroundColor", colorStrings: colorStrings) {
            self.selectedForegroundColor = selectedForegroundColor
        }
        if let disabledForegroundColor = self.parseColor(data: data, key: "disabledForegroundColor", colorStrings: colorStrings) {
            self.disabledForegroundColor = disabledForegroundColor
        }
        
        // Foreground colors
        if let backgroundColor = self.parseColor(data: data, key: "backgroundColor", colorStrings: colorStrings) {
            self.backgroundColor = backgroundColor
        }
        if let highlightedBackgroundColor = self.parseColor(data: data, key: "highlightedBackgroundColor", colorStrings: colorStrings) {
            self.highlightedBackgroundColor = highlightedBackgroundColor
        }
        if let selectedBackgroundColor = self.parseColor(data: data, key: "selectedBackgroundColor", colorStrings: colorStrings) {
            self.selectedBackgroundColor = selectedBackgroundColor
        }
        if let disabledBackgroundColor = self.parseColor(data: data, key: "disabledBackgroundColor", colorStrings: colorStrings) {
            self.disabledBackgroundColor = disabledBackgroundColor
        }
        
        // Border style
        if let borderWidth = data["borderWidth"] as? CGFloat {
            self.borderWidth = borderWidth
        }
        if let borderColor = self.parseColor(data: data, key: "borderColor", colorStrings: colorStrings) {
            self.borderColor = borderColor
        }
        if let highlightedBorderColor = self.parseColor(data: data, key: "highlightedBorderColor", colorStrings: colorStrings) {
            self.highlightedBorderColor = highlightedBorderColor
        }
        if let selectedBorderColor = self.parseColor(data: data, key: "selectedBorderColor", colorStrings: colorStrings) {
            self.selectedBorderColor = selectedBorderColor
        }
        if let disabledBorderColor = self.parseColor(data: data, key: "disabledBorderColor", colorStrings: colorStrings) {
            self.disabledBorderColor = disabledBorderColor
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
        if let tableViewSeparatorColor = self.parseColor(data: data, key: "tableViewSeparatorColor", colorStrings: colorStrings) {
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
    
    private func parseColor(data data:[String:AnyObject], key:String, colorStrings:[String:String])->UIColor? {
        if let colorName = data[key] as? String {
            if let colorString = colorStrings[colorName] {
                return UIColor(hexString: colorString)
            } else {
                return UIColor(hexString: colorName)
            }
        } else {
            return nil
        }
    }
    
    private func parseFont(data data:[String:AnyObject], key:String)->UIFont? {
        if let fontData = data[key] as? [String:AnyObject], name = fontData["name"] as? String, size = fontData["size"] as? CGFloat {
            return UIFont(name: name, size: size)
        } else {
            return nil
        }
    }
}