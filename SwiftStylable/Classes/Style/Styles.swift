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
        if let helper = STHelper.sharedHelper as? SwiftStylableHelper {
            let bundle = NSBundle(forClass: helper.anyProjectClass())
            if let filePath = bundle.pathForResource("styles", ofType: "plist") {
                if let data = NSDictionary(contentsOfFile: filePath) as? [String:AnyObject], styleDatas = data["styles"] as? [[String:AnyObject]] {
                    
                    // Read color strings
                    let colorStrings:[String:String]
                    if let colorEntries = data["colors"] as? [String:String] {
                        colorStrings = colorEntries
                    } else {
                        colorStrings = [String:String]()
                    }
                    
                    // Read styles
                    for styleData in styleDatas {
                        let style = Style(data: styleData, colorStrings: colorStrings)
                        self._styles[style.name] = style
                    }
                }
            }
        }
       
        /*
        // Views
		let viewStyle = Style(name: "view")
		viewStyle.backgroundColor = WT_DEFAULT_APP_BACKGROUND_COLOR
		self.addStyle(viewStyle)
		
        // Content
		let contentStyle = Style(name: "content")
		contentStyle.foregroundColor = WT_DEFAULT_FOREGROUND_COLOR
		contentStyle.backgroundColor = WT_DEFAULT_CONTENT_BACKGROUND_COLOR
		contentStyle.font = UIFont(name: "DINRoundOT", size: 20.0)!
		self.addStyle(contentStyle)
		
        // Header 2
		let header2Style = Style(name: "header 2")
		header2Style.foregroundColor = WT_DEFAULT_FOREGROUND_COLOR
		header2Style.font = UIFont(name: "DINRoundOT-Medium", size: 20.0)!
		self.addStyle(header2Style)
        
        // TableViews
        let tableViewStyle = Style(name: "tableView")
        tableViewStyle.backgroundColor = WT_DEFAULT_CONTENT_BACKGROUND_COLOR
        tableViewStyle.selectedBackgroundColor = WT_EMPHASIS_COLOR
        tableViewStyle.highlightedBackgroundColor = WT_EMPHASIS_COLOR
        tableViewStyle.tableViewSeparatorStyle = .None
        self.addStyle(tableViewStyle)
 */
 
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