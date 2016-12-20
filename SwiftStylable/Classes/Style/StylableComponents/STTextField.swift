//
//  STTextField.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 24/08/16.
//
//

import Foundation
import UIKit

@IBDesignable open class STTextField : UITextField, Stylable {
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STTextField.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STTextField.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
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
        self.backgroundColor = style.backgroundColor
        self.font = style.font
        self.textColor = style.foregroundColor
        self.layer.borderColor = style.borderColor.cgColor
		self.layer.borderWidth = style.borderWidth
		self.layer.masksToBounds = true
        self.borderStyle = style.borderStyle
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
