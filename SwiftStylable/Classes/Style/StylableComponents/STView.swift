//
//  STView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable public class STView : UIView, Stylable
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
    
    public func applyStyle(style:Style) {
        self.backgroundColor = style.backgroundColor
        self.layer.borderWidth = style.borderWidth
        self.layer.borderColor = style.borderColor.CGColor
        self.layer.cornerRadius = style.cornerRadius
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
            self.applyStyle(style)
        }
    }
}