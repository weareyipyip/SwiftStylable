//
//  STButton.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import UIKit

@IBDesignable open class STButton: ExtendedButton, Stylable, BackgroundAndBorderStylable, ForegroundStylable, ImageStylable, TextStylable, SpacingStylable {
	
	private var _stComponentHelper: STComponentHelper!
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self.setUpSTComponentHelper()
    }
    
    required public init(frame: CGRect) {
        super.init(frame: frame)
		self.setUpSTComponentHelper()
    }
    
    open override func updateConfiguration() {
        super.updateConfiguration()
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
	
    @IBInspectable open var imageName:String? {
        didSet {
            self.processImageName(self.imageName, forState: UIControl.State())
        }
    }
    
    @IBInspectable open var highlightedImageName:String? {
        didSet {
            self.processImageName(self.highlightedImageName, forState: .highlighted)
        }
    }
    
    @IBInspectable open var selectedImageName:String? {
        didSet {
            self.processImageName(self.selectedImageName, forState: .selected)
        }
    }
    
    @IBInspectable open var disabledImageName:String? {
        didSet {
            self.processImageName(self.disabledImageName, forState: .disabled)
        }
    }
    
    @IBInspectable open var adjustsFontForContentSizeCategory: Bool {
        get {
            self.titleLabel?.adjustsFontForContentSizeCategory ?? false
            
        }
        set {
            self.titleLabel?.adjustsFontForContentSizeCategory = newValue
        }
    }
    
    var textFont:UIFont? {
        didSet {
            self.titleLabel?.font = self.textFont
            self.updateConfiguration()
        }
    }
    
    var textFontStyle: UIFont.TextStyle? {
        didSet {
            if let font = self.createDynamicFont() {
                self.titleLabel?.font = font
                self.updateConfiguration()
            }
        }
    }
    
    var textFontStyleMaximumSize: CGFloat? {
        didSet {
            if let font = self.createDynamicFont() {
                self.titleLabel?.font = font
                self.updateConfiguration()
            }
        }
    }
    
	open var foregroundColor: UIColor? {
		get {
			return self.titleColor(for: .normal)
		}
		set {
            if #available(iOS 15.0, *) {
                self.configuration?.baseForegroundColor = newValue
            }
            self.setTitleColor(newValue, for: .normal)
		}
	}
	
	open var highlightedForegroundColor: UIColor? {
		get {
			return self.titleColor(for: .highlighted)
		}
		set {
            self.setTitleColor(newValue, for: .highlighted)
		}
	}
	
	open var selectedForegroundColor: UIColor? {
		get {
			return self.titleColor(for: .selected)
		}
		set {
			self.setTitleColor(newValue, for: .selected)
		}
	}
	
	open var disabledForegroundColor: UIColor? {
		get {
			return self.titleColor(for: .disabled)
		}
		set {
			self.setTitleColor(newValue, for: .disabled)
		}
	}
	
	var normalBackgroundColor: UIColor? {
		get {
			return self.backgroundColor(for: .normal)
		}
		set {
			self.setBackgroundColor(newValue, for: .normal)
		}
	}
	
	open var highlightedBackgroundColor: UIColor? {
		get {
			return self.backgroundColor(for: .highlighted)
		}
		set {
			self.setBackgroundColor(newValue, for: .highlighted)
		}
	}
	
	open var selectedBackgroundColor: UIColor? {
		get {
			return self.backgroundColor(for: .selected)
		}
		set {
			self.setBackgroundColor(newValue, for: .selected)
		}
	}
	
	open var disabledBackgroundColor: UIColor? {
		get {
			return self.backgroundColor(for: .disabled)
		}
		set {
			self.setBackgroundColor(newValue, for: .disabled)
		}
	}
	
	open var borderColor: UIColor? {
		get {
			return self.borderColor(for: .normal)
		}
		set {
			self.setBorderColor(newValue, for: .normal)
		}
	}
	
	open var highlightedBorderColor: UIColor? {
		get {
			return self.borderColor(for: .highlighted)
		}
		set {
			self.setBorderColor(newValue, for: .highlighted)
		}
	}
	open var selectedBorderColor: UIColor? {
		get {
			return self.borderColor(for: .selected)
		}
		set {
			self.setBorderColor(newValue, for: .selected)
		}
	}
	
	open var disabledBorderColor: UIColor? {
		get {
			return self.borderColor(for: .disabled)
		}
		set {
			self.setBorderColor(newValue, for: .disabled)
		}
	}
	
	var tintImageWithForegroundColor: Bool {
		get {
			return self.tintImageWithTitleColor
		}
		set {
			self.tintImageWithTitleColor = newValue
		}
	}

    open var imagePadding: CGFloat? {
        didSet {
            if #available(iOS 15.0, *) {
                self.configuration?.imagePadding = self.imagePadding ?? 0
            }
        }
    }
    
    open var titlePadding: CGFloat? {
        didSet {
            if #available(iOS 15.0, *) {
                self.configuration?.titlePadding = self.titlePadding ?? 0
            }
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
	
    open func paintCodeImageNamed(_ name:String)->UIImage? {
        return nil
    }
    
	
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
	
	private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
			BackgroundAndBorderStyler(self, canBeHighlighted: true, canBeSelected: true, canBeDisabled: true),
			ForegroundStyler(self, canBeHighlighted: true, canBeSelected: true, canBeDisabled: true),
			ImageStyler(self),
            TextStyler(self),
            SpacingStyler(self)
		])
	}
	
    private func processImageName(_ imageName:String?, forState state: UIControl.State) {
        if let name = imageName, let image = self.paintCodeImageNamed(name) {
            self.setImage(image, for: state)
        } else {
            self.setImage(nil, for: state)
        }
    }
}
