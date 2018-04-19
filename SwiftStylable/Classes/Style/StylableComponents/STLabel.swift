//
//  STLabel.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class STLabel : UILabel, Stylable, BackgroundAndBorderStylable, ForegroundStylable, TextStylable {
	
	private var _stComponentHelper: STComponentHelper!
	private var _text:String?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self._text = super.text
		self.setUpSTComponentHelper()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
		self._text = super.text
		self.setUpSTComponentHelper()
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
		set {
			self._stComponentHelper.styleName = newValue
		}
		get {
			return self._stComponentHelper.styleName
		}
	}
	
	@IBInspectable open var substyleName:String? {
		set {
			self._stComponentHelper.substyleName = newValue
		}
		get {
			return self._stComponentHelper.substyleName
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
	
	open var fullUppercaseText = false {
		didSet {
			self.text = self._text
		}
	}
	
	var foregroundColor: UIColor? {
		set {
			self.textColor = newValue ?? UIColor.black
		}
		get {
			return self.textColor
		}
	}
    
    var textFont: UIFont? {
        set {
            if let font = newValue {
                self.font = font
            }
        }
        get {
            return self.font
        }
    }

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
		self._stComponentHelper.applyStyle(style)
    }
    
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private func setUpSTComponentHelper() {
		self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
			BackgroundAndBorderStylePropertySet(self),
			ForegroundStylePropertySet(self),
			TextStylePropertySet(self)
		])
	}

}
