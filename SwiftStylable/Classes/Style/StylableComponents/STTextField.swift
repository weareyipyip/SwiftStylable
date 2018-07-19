//
//  STTextField.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 24/08/16.
//
//

import Foundation
import UIKit

@IBDesignable open class STTextField : UITextField, Stylable, BackgroundAndBorderStylable, TextBorderStylable, ForegroundStylable, TextStylable, PlaceholderTextStylable  {
    
    private var _stComponentHelper: STComponentHelper!
    private var _text:String?
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpSTComponentHelper()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpSTComponentHelper()
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
    
    open var foregroundColor: UIColor? {
        set {
            self.textColor = newValue ?? UIColor.black
        }
        get {
            return self.textColor
        }
    }
    
    open var attributedPlaceholderString:NSAttributedString? {
        set {
            self.attributedPlaceholder = newValue
        }
        get {
            return self.attributedPlaceholder
        }
    }
    
    open var textFont:UIFont? {
        set {
            if let font = newValue {
                self.font = font
            }
        }
        get {
            return self.font
        }
    }
    
    open var fullUppercaseText:Bool = false {
        didSet {
            self.text = self._text
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self._stComponentHelper.applyStyle(style)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
            BackgroundAndBorderStylePropertySet(self),
            TextBorderStylePropertySet(self),
            ForegroundStylePropertySet(self),
            TextStylePropertySet(self),
            PlaceholderTextStylePropertySet(self)
        ])
    }
}
