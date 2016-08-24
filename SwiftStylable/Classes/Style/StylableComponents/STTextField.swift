//
//  STTextField.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 24/08/16.
//
//

import Foundation
import UIKit

@IBDesignable public class STTextField : UITextField, Stylable {
    
    @IBInspectable public var styleName:String? {
        didSet {
            if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    
    public func applyStyle(style:Style) {
        self.backgroundColor = style.backgroundColor
        self.font = style.font
        self.textColor = style.foregroundColor
        self.layer.borderColor = style.borderColor
        self.borderStyle = style.borderStyle
    }
}
