//
//  STActivityIndicator.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 31/08/16.
//
//

import Foundation
import UIKit

@IBDesignable public class STActivityIndicator : UIActivityIndicatorView, Stylable {
    
    @IBInspectable public var styleName:String? {
        didSet {
            if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    
    public func applyStyle(style:Style) {
        self.tintColor = style.foregroundColor
    }
}
