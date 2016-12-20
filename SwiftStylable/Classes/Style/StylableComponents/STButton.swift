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
    
    override public init(frame: CGRect) {
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
            if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
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
        self.setBackgroundColor(style.backgroundColor, forState: UIControlState())
        self.setBackgroundColor(style.highlightedBackgroundColor, forState: .highlighted)
        self.setBackgroundColor(style.selectedBackgroundColor, forState: .selected)
        self.setBackgroundColor(style.disabledBackgroundColor, forState: .disabled)
        
        self.setBorderColor(style.borderColor, forState: UIControlState())
        self.setBorderColor(style.highlightedBorderColor, forState: .highlighted)
        self.setBorderColor(style.selectedBorderColor, forState: .selected)
        self.setBorderColor(style.disabledBorderColor, forState: .disabled)
        
        self.setTitleColor(style.foregroundColor, for: UIControlState())
        self.setTitleColor(style.highlightedForegroundColor, for: .highlighted)
        self.setTitleColor(style.selectedForegroundColor, for: .selected)
        self.setTitleColor(style.disabledForegroundColor, for: .disabled)
		
		self.tintImageWithTitleColor = style.tintImageWithForegroundColor
        
        self.titleLabel?.font = style.font

		self.layer.borderWidth = style.borderWidth
        self.layer.cornerRadius = style.cornerRadius
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
