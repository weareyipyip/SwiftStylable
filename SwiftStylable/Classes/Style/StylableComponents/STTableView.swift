//
//  STTableView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable public class STTableView : UITableView, Stylable
{
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(STTableView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
        
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable public var styleName:String? {
        didSet {
            if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public func applyStyle(style:Style) {
        self.backgroundColor = style.backgroundColor
        self.layer.borderWidth = style.borderWidth
        self.layer.borderColor = style.borderColor.CGColor
        self.layer.cornerRadius = style.cornerRadius
        self.separatorStyle = style.tableViewSeparatorStyle
        self.separatorColor = style.tableViewSeparatorColor
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
	func stylesDidUpdate(notification:NSNotification) {
		if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
			self.applyStyle(style)
		}
	}
}