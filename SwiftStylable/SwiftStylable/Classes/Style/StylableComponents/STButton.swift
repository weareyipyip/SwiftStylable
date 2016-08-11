//
//  STButton.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation


@IBDesignable public class STButton : ExtendedButton, Stylable {
    @IBInspectable public var styleName:String? {
        didSet {
            if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    public func applyStyle(style:Style) {
        self.setBackgroundColor(style.backgroundColor, forState: .Normal)
        self.setBackgroundColor(style.highlightedBackgroundColor, forState: .Highlighted)
        self.setBackgroundColor(style.selectedBackgroundColor, forState: .Selected)
        self.setBackgroundColor(style.disabledBackgroundColor, forState: .Disabled)
        
        self.setBorderColor(style.borderColor, forState: .Normal)
        self.setBorderColor(style.highlightedBorderColor, forState: .Highlighted)
        self.setBorderColor(style.selectedBorderColor, forState: .Selected)
        self.setBorderColor(style.disabledBorderColor, forState: .Disabled)
        
        self.setTitleColor(style.foregroundColor, forState: .Normal)
        self.setTitleColor(style.highlightedForegroundColor, forState: .Highlighted)
        self.setTitleColor(style.selectedForegroundColor, forState: .Selected)
        self.setTitleColor(style.disabledForegroundColor, forState: .Disabled)
        
        self.layer.cornerRadius = style.cornerRadius
    }
}
