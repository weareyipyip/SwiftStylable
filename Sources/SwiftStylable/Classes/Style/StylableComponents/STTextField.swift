//
//  STTextField.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 24/08/16.
//
//

import UIKit

@IBDesignable open class STTextField : UITextField, UITextFieldDelegate, Stylable, BackgroundAndBorderStylable, TextBorderStylable, ForegroundStylable, TextStylable, PlaceholderStylable  {
    
    private var _stComponentHelper: STComponentHelper!
    private var _styledText:String?
    private var _placeholder:String?
    private var _styledPlaceholder:String?
	private var _delegate:UITextFieldDelegate?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self._placeholder = super.placeholder
        self.setUpSTComponentHelper()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
		self._placeholder = super.placeholder
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
            if let text = newValue {
                var attributes = self.styledTextAttributes ?? [:]
                if let textFontStyle, let textFont = attributes[NSAttributedString.Key.font] as? UIFont {
                    attributes[NSAttributedString.Key.font] = UIFontMetrics(forTextStyle: textFontStyle).scaledFont(for: textFont)
                }
                super.attributedText = NSAttributedString(string: text, attributes: attributes)
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
        didSet {
            self.font = self.textFont
        }
    }
    
    open var textFontStyle: UIFont.TextStyle? {
        didSet {
            guard let textFontStyle, let textFont else { return }
            self.font = UIFontMetrics(forTextStyle: textFontStyle).scaledFont(for: textFont)
        }
    }
    
	open var fullUppercaseText = false {
		didSet {
			if self.fullUppercaseText {
				print("WARNING: fullUppercaseText is not supported by STTextView and STTextField!")
			}
		}
	}

    open override var placeholder: String? {
        set {
            self._placeholder = newValue
            super.placeholder = self.fullUppercasePlaceholder ? newValue?.uppercased() : newValue
            self._styledPlaceholder = nil
        }
        get {
            return self._placeholder
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
                var attributes = self.styledPlaceholderAttributes ?? [:]
                if let textFontStyle, let textFont = attributes[NSAttributedString.Key.font] as? UIFont {
                    attributes[NSAttributedString.Key.font] = UIFontMetrics(forTextStyle: textFontStyle).scaledFont(for: textFont)
                }
				let casedPlaceholder = self.fullUppercasePlaceholder ? placeholder.uppercased() : placeholder
                super.attributedPlaceholder = NSAttributedString(string: casedPlaceholder, attributes: attributes)
            }
        }
        get {
            return self._styledPlaceholder
        }
    }

    @IBInspectable override open var adjustsFontForContentSizeCategory: Bool {
        get {
            super.adjustsFontForContentSizeCategory
            
        }
        set {
            super.adjustsFontForContentSizeCategory = newValue
        }
    }
    
    open var fullUppercasePlaceholder:Bool = false {
        didSet {
            self.placeholder = self._placeholder
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
            BackgroundAndBorderStyler(self),
            TextBorderStyler(self),
            ForegroundStyler(self),
            TextStyler(self),
            PlaceholderTextStyler(self)
        ])
    }
}
