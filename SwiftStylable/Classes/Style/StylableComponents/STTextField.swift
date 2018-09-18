//
//  STTextField.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 24/08/16.
//
//

import Foundation
import UIKit

@IBDesignable open class STTextField : UITextField, Stylable, BackgroundAndBorderStylable, TextBorderStylable, ForegroundStylable, TextStylable, PlaceholderStylable  {
    
    private var _stComponentHelper: STComponentHelper!
    private var _text:String?
    private var _styledText:String?
    private var _placeholder:String?
    private var _styledPlaceholder:String?

    
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
            self._styledText = nil
        }
        get {
            return self._text
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            self._styledText = nil
        }
    }

    var styledTextAttributes:[NSAttributedString.Key:Any]? {
        didSet {
            if self._styledText != nil {
                self.styledText = self._styledText
            }
        }
    }
    
    @IBInspectable open var styledText:String? {
        set {
            self._styledText = newValue
            self._text = newValue
            if let text = newValue {
                super.attributedText = NSAttributedString(string: text, attributes: self.styledTextAttributes ?? [NSAttributedString.Key:Any]())
            }
        }
        get {
            return self._styledText
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
    
    open override var placeholder: String? {
        set {
            self._placeholder = newValue
            super.placeholder = self.fullUppercasePlaceholder ? newValue?.uppercased() : newValue
            self._styledPlaceholder = nil
        }
        get {
            return self._text
        }
    }
    
    open override var attributedPlaceholder: NSAttributedString? {
        didSet {
            self._styledPlaceholder = nil
        }
    }
    
    var styledPlaceholderAttributes:[NSAttributedString.Key:Any]? {
        didSet {
            if self._styledPlaceholder != nil {
                self.styledPlaceholder = self._styledPlaceholder
            }
        }
    }
    
    @IBInspectable open var styledPlaceholder:String? {
        set {
            self._styledPlaceholder = newValue
            self._placeholder = newValue
            if let placeholder = newValue {
                super.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: self.styledPlaceholderAttributes ?? [NSAttributedString.Key:Any]())
            }
        }
        get {
            return self._styledPlaceholder
        }
    }

    open var fullUppercasePlaceholder:Bool = false {
        didSet {
            self.placeholder = self._placeholder
        }
    }
    
//    var fullUppercasePlaceholderText:Bool? { get set }
//    var styledPlaceholderTextAttributes:[NSAttributedStringKey:Any]? { get set }

    
    
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
