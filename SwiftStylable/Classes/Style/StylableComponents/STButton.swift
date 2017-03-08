//
//  STButton.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation


@IBDesignable open class STButton : ExtendedButton, Stylable {
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STButton.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    required public init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STButton.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
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
            if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    @IBInspectable open var imageName:String? {
        didSet {
            self.processImageName(self.imageName, forState: UIControlState())
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
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
		
		// Background colors
		if let backgroundColor = style.backgroundColor {
			self.setBackgroundColor(backgroundColor, forState: UIControlState())
		}
		if let highlightedBackgroundColor = style.highlightedBackgroundColor {
			self.setBackgroundColor(highlightedBackgroundColor, forState: .highlighted)
		}
		if let selectedBackgroundColor = style.selectedBackgroundColor {
			self.setBackgroundColor(selectedBackgroundColor, forState: .selected)
		}
		if let disabledBackgroundColor = style.disabledBackgroundColor {
			self.setBackgroundColor(disabledBackgroundColor, forState: .disabled)
		}
		
		// Border style
		if let borderColor = style.borderColor {
			self.setBorderColor(borderColor, forState: UIControlState())
		}
		if let highlightedBorderColor = style.highlightedBorderColor {
			self.setBorderColor(highlightedBorderColor, forState: .highlighted)
		}
		if let selectedBorderColor = style.selectedBorderColor {
			self.setBorderColor(selectedBorderColor, forState: .selected)
		}
		if let disabledBorderColor = style.disabledBorderColor {
			self.setBorderColor(disabledBorderColor, forState: .disabled)
		}
		if let borderWidth = style.borderWidth {
			self.layer.borderWidth = borderWidth
		}
		
		// Foreground colors
		if let foregroundColor = style.foregroundColor {
			self.setTitleColor(foregroundColor, for: UIControlState())
		}
		if let highlightedForegroundColor = style.highlightedForegroundColor {
			self.setTitleColor(highlightedForegroundColor, for: .highlighted)
		}
		if let selectedForegroundColor = style.selectedForegroundColor {
			self.setTitleColor(selectedForegroundColor, for: .selected)
		}
		if let disabledForegroundColor = style.disabledForegroundColor {
			self.setTitleColor(disabledForegroundColor, for: .disabled)
		}
		if let tintImageWithForegroundColor = style.tintImageWithForegroundColor {
			self.tintImageWithTitleColor = tintImageWithForegroundColor
		}

		// Text
		if let font = style.font {
			self.titleLabel?.font = font
		}
		if let fullUppercaseText = style.fullUppercaseText {
			self.fullUppercaseText = fullUppercaseText
		}
		
		// Corner radius
		if let cornerRadius = style.cornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    func stylesDidUpdate(_ notification:Notification) {
        if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
            self.applyStyle(style)
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    fileprivate func processImageName(_ imageName:String?, forState state: UIControlState) {
        if let name = imageName, let helper = STHelper.sharedHelper as? SwiftStylableHelper, let image = helper.imageNamed(name) {
            self.setImage(image, for: state)
        } else {
            self.setImage(nil, for: state)
        }
    }
}
