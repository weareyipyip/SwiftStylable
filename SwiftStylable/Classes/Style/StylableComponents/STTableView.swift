//
//  STTableView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STTableView : UITableView, Stylable
{
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STTableView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable open var styleName:String? {
        didSet {
            if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
		if let backgroundColor = style.backgroundColor {
			self.backgroundColor = backgroundColor
		}
		if let borderWidth = style.borderWidth {
			self.layer.borderWidth = borderWidth
		}
		if let borderColor = style.borderColor {
			self.layer.borderColor = borderColor.cgColor
		}
		if let cornerRadius = style.cornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
		if let tableViewSeparatorStyle = style.tableViewSeparatorStyle {
			self.separatorStyle = tableViewSeparatorStyle
		}
		if let tableViewSeparatorColor = style.tableViewSeparatorColor {
			self.separatorColor = tableViewSeparatorColor
		}
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
	func stylesDidUpdate(_ notification:Notification) {
		if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
			self.applyStyle(style)
		}
	}
}
