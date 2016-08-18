//
//  STLabel.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class STLabel : UILabel, Stylable {

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
        self.font = style.font
        self.textColor = style.foregroundColor
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
            self.applyStyle(style)
        }
    }
}
