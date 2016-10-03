//
//  STView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STView : UIView, Stylable
{
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STView.stylesDidUpdate(_:)), name: NSNotification.Name(rawValue: STYLES_DID_UPDATE), object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STView.stylesDidUpdate(_:)), name: NSNotification.Name(rawValue: STYLES_DID_UPDATE), object: nil)
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
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
	func stylesDidUpdate(_ notification:Notification) {
		if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
			self.applyStyle(style)
		}
	}
	

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self.backgroundColor = style.backgroundColor
        self.layer.borderWidth = style.borderWidth
        self.layer.borderColor = style.borderColor.cgColor
        self.layer.cornerRadius = style.cornerRadius
    }
}
