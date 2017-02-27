//
//  STHorizontalHairline.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 27/02/2017.
//
//

import Foundation
import UIKit


@IBDesignable class STHorizontalHairline : UIView, Stylable {
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------

    override var intrinsicContentSize:CGSize {
        get {
            return CGSize(width: 1.0, height: CGFloat(1.0 / UIScreen.main.nativeScale))
        }
    }
    
    @IBInspectable open var styleName:String? {
        didSet {
            if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self.backgroundColor = style.backgroundColor
    }
}
