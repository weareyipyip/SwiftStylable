//
//  STLabel.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class STLabel : UILabel, Stylable {
	
	var fullUppercaseText = false
	
	private var _text:String?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		
		self._text = super.text
        NotificationCenter.default.addObserver(self, selector: #selector(STLabel.stylesDidUpdate(_:)), name: NSNotification.Name(rawValue: STYLES_DID_UPDATE), object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
		self._text = super.text
        NotificationCenter.default.addObserver(self, selector: #selector(STLabel.stylesDidUpdate(_:)), name: NSNotification.Name(rawValue: STYLES_DID_UPDATE), object: nil)
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
	
	open override var text: String? {
		set {
			self._text = newValue
			super.text = self.fullUppercaseText ? newValue?.uppercased() : newValue
		}
		get {
			return self._text
		}
	}

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self.font = style.font
        self.textColor = style.foregroundColor
		self.fullUppercaseText = style.fullUppercaseText
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
