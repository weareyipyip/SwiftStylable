//
//  STTextView.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 08/05/2017.
//
//

import UIKit

@IBDesignable open class STTextView : UITextView, UITextViewDelegate, Stylable, BackgroundAndBorderStylable, ForegroundStylable, TextStylable, StyledTextStylable {

    private var _stComponentHelper: STComponentHelper!
    private var _styledText:String?
	
	
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUpSTComponentHelper()
    }
    
    override public init(frame: CGRect, textContainer:NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
        
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
		didSet {
            self._styledText = nil
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            self._styledText = nil
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
            if let font = self.createDynamicFont() {
                self.font = font
            }
        }
    }
    
    open var textFontStyleMaximumSize: CGFloat? {
        didSet {
            if let font = self.createDynamicFont() {
                self.font = font
            }
        }
    }
    
    open var styledTextAttributes:[NSAttributedString.Key:Any]? {
        didSet {
            if self._styledText != nil {
                self.styledText = self._styledText
            }
        }
    }
    
    var styledTextFontStyle: UIFont.TextStyle? {
        didSet {
            if self._styledText != nil {
                self.styledText = self._styledText
            }
        }
    }
    
    var styledTextFontStyleMaximumSize: CGFloat? {
        didSet {
            if self._styledText != nil {
                self.styledText = self._styledText
            }
        }
    }

    open var fullUppercaseText = false {
        didSet {
			if self.fullUppercaseText {
				print("WARNING: fullUppercaseText is not supported by STTextView and STTextField!")
			}
        }
    }
    
    @IBInspectable open var styledText:String? {
        set {
            self._styledText = newValue
            if let text = newValue {
                var attributes = self.styledTextAttributes ?? [:]
                if attributes[NSAttributedString.Key.font] != nil, let dynamicFont = self.createStyledTextDynamicFont() {
                    attributes[NSAttributedString.Key.font] = dynamicFont
                }
                super.attributedText = NSAttributedString(string: text, attributes: attributes)
            }
        }
        get {
            return self._styledText
        }
    }
    
    @IBInspectable open override var adjustsFontForContentSizeCategory: Bool {
        get {
            return super.adjustsFontForContentSizeCategory
        }
        set {
            super.adjustsFontForContentSizeCategory = newValue
        }
    }

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        if let font = style.textStyle.font {
            self.font = font
        }
        if let foregroundColor = style.foregroundStyle.foregroundColor {
            self.textColor = foregroundColor
        }
        if let fullUppercaseText = style.textStyle.fullUppercaseText {
            self.fullUppercaseText = fullUppercaseText
        }
    }
    
	
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
	
    private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
            BackgroundAndBorderStyler(self),
            ForegroundStyler(self),
            TextStyler(self),
            StyledTextStyler(self)
        ])
    }
}
