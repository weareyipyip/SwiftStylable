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
    @IBInspectable public var styleName:String? {
        didSet {
            #if !TARGET_INTERFACE_BUILDER
                if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                    self.applyStyle(style)
                }
            #endif
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
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

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
            self.applyStyle(style)
        }
    }
}