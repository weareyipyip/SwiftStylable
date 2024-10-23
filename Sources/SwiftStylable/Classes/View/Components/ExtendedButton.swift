//
//  ExtendedButton.swift
//  YipYipSwift
//
//  Created by Marcel Bloemendaal on 08/01/15.
//  Copyright (c) 2015 Marcel Bloemendaal. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class ExtendedButton: UIButton {
    
    private var _normalBackgroundColor:UIColor?
    private var _highlightedBackgroundColor:UIColor?
    private var _selectedBackgroundColor:UIColor?
    private var _disabledBackgroundColor:UIColor?
    
    private var _normalBorderColor:UIColor?
    private var _highlightedBorderColor:UIColor?
    private var _selectedBorderColor:UIColor?
    private var _disabledBorderColor:UIColor?
    
    private var _normalTitle:String?
    private var _highlightedTitle:String?
    private var _selectedTitle:String?
    private var _disabledTitle:String?
    
    private var _customHorizontalTitleAlignment:UIControl.ContentHorizontalAlignment = .center
    private var _customVerticalTitleAlignment:UIControl.ContentVerticalAlignment = .center
    private var _customHorizontalImageAlignment:UIControl.ContentHorizontalAlignment = .center
    private var _customVerticalImageAlignment:UIControl.ContentVerticalAlignment = .center
    
    private var _defaultHorizontalContentAlignment = UIControl.ContentHorizontalAlignment.center
    private var _defaultVerticalContentAlignment = UIControl.ContentVerticalAlignment.center
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self._init()
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    // -----------------------------------------------------------
    // MARK: -- Layout
    // -----------------------------------------------------------
    
    @IBInspectable override open var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment {
        get {
            return super.contentHorizontalAlignment
        }
        set {
            self._defaultHorizontalContentAlignment = newValue
            if #unavailable(iOS 15.0) {
                if !self.customItemPlacement {
                    super.contentHorizontalAlignment = newValue
                }
            } else {
                super.contentHorizontalAlignment = newValue
            }
        }
    }
    
    @IBInspectable override open var contentVerticalAlignment: UIControl.ContentVerticalAlignment {
        get {
            return super.contentVerticalAlignment
        }
        set {
            self._defaultVerticalContentAlignment = newValue
            if #unavailable(iOS 15.0) {
                if !self.customItemPlacement {
                    super.contentVerticalAlignment = newValue
                }
            } else {
                super.contentVerticalAlignment = newValue
            }
        }
    }
    
    open override var contentEdgeInsets: UIEdgeInsets {
        set {
            if #available(iOS 15.0, *) {
                self.configuration?.contentInsets = NSDirectionalEdgeInsets(
                    top: newValue.top,
                    leading: newValue.left,
                    bottom: newValue.bottom,
                    trailing: newValue.right
                )
            } else {
                super.contentEdgeInsets = newValue
            }
        }
        get {
            if #available(iOS 15.0, *) {
                if let contentInsets = self.configuration?.contentInsets {
                    return UIEdgeInsets(
                        top: contentInsets.top,
                        left: contentInsets.leading,
                        bottom: contentInsets.bottom,
                        right: contentInsets.trailing
                    )
                } else {
                    return .zero
                }
            } else {
                return super.contentEdgeInsets
            }
        }
    }
    
    @available(iOS, deprecated: 15, message: "'customItemPlacement' is deprecated since the use of UIButtonConfiguration.")
    @IBInspectable open var customItemPlacement:Bool = false {
        didSet {
            if self.customItemPlacement {
                super.contentHorizontalAlignment = .center
                super.contentVerticalAlignment = .center
            } else {
                self.contentHorizontalAlignment = self._defaultHorizontalContentAlignment
                self.contentVerticalAlignment = self._defaultVerticalContentAlignment
            }
        }
    }
    
    @available(iOS, deprecated: 15, message: "'titlePlacementIndex' is deprecated since the use of UIButtonConfiguration.")
    @IBInspectable open var titlePlacementIndex:Int = 4 {
        didSet {
            if self.titlePlacementIndex > -1 && self.titlePlacementIndex < 9 {
                switch self.titlePlacementIndex % 3 {
                case 0:
                    self._customHorizontalTitleAlignment = .left
                    
                case 2:
                    self._customHorizontalTitleAlignment = .right
                    
                default:
                    self._customHorizontalTitleAlignment = .center
                }
                switch self.titlePlacementIndex / 3 {
                case 0:
                    self._customVerticalTitleAlignment = .top
                    
                case 2:
                    self._customVerticalTitleAlignment = .bottom
                    
                default:
                    self._customVerticalTitleAlignment = .center
                }
                self.setNeedsLayout()
            } else {
                self._customHorizontalTitleAlignment = .center
                self._customVerticalTitleAlignment = .center
            }
        }
    }
    
    @available(iOS, deprecated: 15, message: "'imagePlacementIndex' is deprecated since the use of UIButtonConfiguration.")
    @IBInspectable open var imagePlacementIndex:Int = 4 {
        didSet {
            if self.imagePlacementIndex > -1 && self.imagePlacementIndex < 9 {
                switch self.imagePlacementIndex % 3 {
                case 0:
                    self._customHorizontalImageAlignment = .left
                    
                case 2:
                    self._customHorizontalImageAlignment = .right
                    
                default:
                    self._customHorizontalImageAlignment = .center
                }
                switch self.imagePlacementIndex / 3 {
                case 0:
                    self._customVerticalImageAlignment = .top
                    
                case 2:
                    self._customVerticalImageAlignment = .bottom
                    
                default:
                    self._customVerticalImageAlignment = .center
                }
                self.setNeedsLayout()
            } else {
                self._customHorizontalImageAlignment = .center
                self._customVerticalImageAlignment = .center
            }
        }
    }
    
    
    // -----------------------------------------------------------
    // MARK: -- States
    // -----------------------------------------------------------
    
    override open var isHighlighted:Bool {
        didSet {
            if #available(iOS 15.0, *) {
                self.setNeedsUpdateConfiguration()
            } else {
                self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
            }
        }
    }
    
    override open var isSelected:Bool {
        didSet {
            if #available(iOS 15.0, *) {
                self.setNeedsUpdateConfiguration()
            } else {
                self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
            }
        }
    }
    
    override open var isEnabled:Bool {
        get	{
            return super.isEnabled
        }
        set(value) {
            super.isEnabled = value
            if #available(iOS 15.0, *) {
                self.setNeedsUpdateConfiguration()
            } else {
                self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
            }
        }
    }
    
    @IBInspectable open var tintImageWithTitleColor:Bool = false {
        didSet {
            if self.tintImageWithTitleColor != oldValue {
                self.updateImageRenderingModeForState(.normal)
                self.updateImageRenderingModeForState(.highlighted)
                self.updateImageRenderingModeForState(.selected)
                self.updateImageRenderingModeForState(.disabled)
            }
            if #available(iOS 15.0, *) {
                self.setNeedsUpdateConfiguration()
            } else {
                self.updateColors(updateImageTintColor: true)
            }
        }
    }
    
    @IBInspectable open var fullUppercaseText:Bool = false {
        didSet {
            if self.fullUppercaseText != oldValue {
                super.setTitle(self.fullUppercaseText ? self._normalTitle?.uppercased() : self._normalTitle, for: .normal)
                super.setTitle(self.fullUppercaseText ? self._highlightedTitle?.uppercased() : self._highlightedTitle, for: .highlighted)
                super.setTitle(self.fullUppercaseText ? self._selectedTitle?.uppercased() : self._selectedTitle, for: .selected)
                super.setTitle(self.fullUppercaseText ? self._disabledTitle?.uppercased() : self._disabledTitle, for: .disabled)
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // -----------------------------------------------------------
    //  UIButton overrides
    // -----------------------------------------------------------
    
    // -----------------------------------------------------------
    //  Extra state color properties
    // -----------------------------------------------------------
    
    open func setBackgroundColor(_ color:UIColor?, for state:UIControl.State)
    {
        switch (state)
        {
        case UIControl.State.normal:
            _normalBackgroundColor = color
            
        case UIControl.State.highlighted:
            _highlightedBackgroundColor = color
            
        case UIControl.State.selected:
            _selectedBackgroundColor = color
            
        case UIControl.State.disabled:
            _disabledBackgroundColor = color
            
        default:
            break;
        }
        if #available(iOS 15.0, *) {
            self.setNeedsUpdateConfiguration()
        } else {
            self.updateColors(updateImageTintColor: false)
        }
    }
    
    open func backgroundColor(for state:UIControl.State)->UIColor? {
        var color:UIColor?
        
        switch (state)
        {
        case UIControl.State.normal:
            color = self._normalBackgroundColor
            
        case UIControl.State.highlighted:
            color = self._highlightedBackgroundColor
            
        case UIControl.State.selected:
            color = self._selectedBackgroundColor
            
        case UIControl.State.disabled:
            color = self._disabledBackgroundColor
            
        default:
            color = nil
        }
        return color
    }
    
    open func setBorderColor(_ color:UIColor?, for state:UIControl.State)
    {
        switch (state)
        {
        case UIControl.State.normal:
            _normalBorderColor = color
            break
            
        case UIControl.State.highlighted:
            _highlightedBorderColor = color
            break
            
        case UIControl.State.selected:
            _selectedBorderColor = color
            break
            
        case UIControl.State.disabled:
            _disabledBorderColor = color
            break
            
        default:
            break
        }
        if #available(iOS 15.0, *) {
            self.setNeedsUpdateConfiguration()
        } else {
            self.updateColors(updateImageTintColor: false)
        }
    }
    
    open func borderColor(for state:UIControl.State)->UIColor? {
        var color:UIColor?
        
        switch (state)
        {
        case UIControl.State.normal:
            color = self._normalBorderColor
            
        case UIControl.State.highlighted:
            color = self._highlightedBorderColor
            
        case UIControl.State.selected:
            color = self._selectedBorderColor
            
        case UIControl.State.disabled:
            color = self._disabledBorderColor
            
        default:
            color = nil
        }
        return color
    }
    
    
    
    open override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        if #available(iOS 15.0, *) {
            self.setNeedsUpdateConfiguration()
        } else {
            self.updateColors(updateImageTintColor: self.tintImageWithTitleColor && self.state == state)
        }
    }
    
    open override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.updateImageRenderingModeForState(state)
        if #available(iOS 15.0, *) {
            self.setNeedsUpdateConfiguration()
        } else {
            self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
        }
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        switch state {
        case UIControl.State.normal:
            self._normalTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        case UIControl.State.highlighted:
            self._highlightedTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        case UIControl.State.selected:
            self._selectedTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        case UIControl.State.disabled:
            self._disabledTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        default:
            super.setTitle(title, for: state)
        }
    }
    
    open override func title(for state: UIControl.State)->String? {
        switch state {
        case UIControl.State.normal:
            return self._normalTitle
            
        case UIControl.State.highlighted:
            return self._highlightedTitle
            
        case UIControl.State.selected:
            return self._selectedTitle
            
        case UIControl.State.disabled:
            return self._disabledTitle
            
        default:
            return super.title(for: state)
        }
    }
    
    // -----------------------------------------------------------
    // MARK: -- Layout methods
    // -----------------------------------------------------------
    
    @available(iOS, deprecated: 15, message: "'titleRect(forContentRect:)' is deprecated since the use of UIButtonConfiguration.")
    open override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if self.customItemPlacement {
            let titleSize = super.titleRect(forContentRect: CGRect(x: 0.0, y: 0.0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).size
            var x:CGFloat = 0.0
            var y:CGFloat = 0.0
            let width:CGFloat = min(titleSize.width, contentRect.width)
            let height:CGFloat = min(titleSize.height, contentRect.height)
            switch self._customHorizontalTitleAlignment {
            case .left:
                x = contentRect.minX + self.titleEdgeInsets.left
                
            case .right:
                x = contentRect.maxX - width - self.titleEdgeInsets.right
                
            default:
                // Center
                x = ((contentRect.minX + self.titleEdgeInsets.left) + (contentRect.maxX - self.titleEdgeInsets.right)) * 0.5 - width * 0.5
            }
            switch self._customVerticalTitleAlignment {
            case .top:
                y = contentRect.minY + self.titleEdgeInsets.top
                
            case .bottom:
                y = contentRect.maxY - height - self.titleEdgeInsets.bottom
                
            default:
                // Center
                y = ((contentRect.minY + self.titleEdgeInsets.top) + (contentRect.maxY - self.titleEdgeInsets.bottom)) * 0.5 - height * 0.5
            }
            
            return CGRect(x: x,
                          y: y,
                          width: width,
                          height: height)
            
        } else {
            return super.titleRect(forContentRect: contentRect)
        }
    }
    
    @available(iOS, deprecated: 15, message: "'imageRect(forContentRect:)' is deprecated since the use of UIButtonConfiguration.")
    open override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if self.customItemPlacement {
            let imageSize = super.imageRect(forContentRect: CGRect(x: 0.0, y: 0.0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).size
            var x:CGFloat = 0.0
            var y:CGFloat = 0.0
            let width:CGFloat = min(imageSize.width, contentRect.width)
            let height:CGFloat = min(imageSize.height, contentRect.height)
            switch self._customHorizontalImageAlignment {
            case .left:
                x = contentRect.minX + self.imageEdgeInsets.left
                
            case .right:
                x = contentRect.maxX - width - self.imageEdgeInsets.right
                
            default:
                // Center
                x = ((contentRect.minX + self.imageEdgeInsets.left) + (contentRect.maxX - self.imageEdgeInsets.right)) * 0.5 - width * 0.5
            }
            switch self._customVerticalImageAlignment {
            case .top:
                y = contentRect.minY + self.imageEdgeInsets.top
                
            case .bottom:
                y = contentRect.maxY - height - self.imageEdgeInsets.bottom
                
            default:
                // Center
                y = ((contentRect.minY + self.imageEdgeInsets.top) + (contentRect.maxY - self.imageEdgeInsets.bottom)) * 0.5 - height * 0.5
            }
            
            return CGRect(x: x,
                          y: y,
                          width: width,
                          height: height)
            
        } else {
            return super.imageRect(forContentRect: contentRect)
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func _init() {
        self._normalTitle = super.title(for: .normal)
        self._highlightedTitle = super.title(for: .highlighted)
        self._selectedTitle = super.title(for: .selected)
        self._disabledTitle = super.title(for: .disabled)
        
        self._defaultHorizontalContentAlignment = self.contentHorizontalAlignment
        self._defaultVerticalContentAlignment = self.contentVerticalAlignment
        
        if #available(iOS 15.0, *) {
            self.configuration = UIButton.Configuration.plain()
        }
    }
    
    open override func updateConfiguration() {
        if #available(iOS 15.0, *) {
            super.updateConfiguration()
            
            switch self.state {
            case .normal:
                
                // Apperance
                let backgroundColor = self._normalBackgroundColor
                self.backgroundColor = backgroundColor
                self.configuration?.baseBackgroundColor = backgroundColor
                self.layer.borderColor = (self._normalBorderColor ?? UIColor.clear).cgColor
                
                // Title
                self.configuration?.title = self._normalTitle
                self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                    var newAttributes = attributes
                    newAttributes.foregroundColor = self.titleColor(for: .normal)
                    newAttributes.font = self.titleLabel?.font
                    return newAttributes
                }
                
                // Image
                if self.tintImageWithTitleColor, self.imageView != nil {
                    self.configuration?.imageColorTransformer = UIConfigurationColorTransformer { _ in
                        return self.titleColor(for: .normal) ?? self.configuration?.baseForegroundColor ?? UIColor.white
                    }
                }
                
            case .highlighted:
                
                // Apperance
                let backgroundColor = self._highlightedBackgroundColor ?? self._normalBackgroundColor
                self.backgroundColor = backgroundColor
                self.configuration?.baseBackgroundColor = backgroundColor
                self.layer.borderColor = self._highlightedBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
                
                // Title
                self.configuration?.title = self._highlightedTitle ?? self._normalTitle
                self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                    var newAttributes = attributes
                    newAttributes.foregroundColor = self.titleColor(for: .highlighted)
                    newAttributes.font = self.titleLabel?.font
                    return newAttributes
                }
                
                // Image
                if self.tintImageWithTitleColor, self.imageView != nil {
                    self.configuration?.imageColorTransformer = UIConfigurationColorTransformer { _ in
                        return self.titleColor(for: .highlighted) ?? self.titleColor(for: .normal) ?? self.configuration?.baseForegroundColor ?? UIColor.white
                    }
                }
                
            case .selected:
                
                // Apperance
                let backgroundColor = self._selectedBackgroundColor ?? self._normalBackgroundColor
                self.backgroundColor = backgroundColor
                self.configuration?.baseBackgroundColor = backgroundColor
                self.layer.borderColor = self._selectedBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
                
                // Title
                self.configuration?.title = self._selectedTitle ?? self._normalTitle
                self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                    var newAttributes = attributes
                    newAttributes.foregroundColor = self.titleColor(for: .selected)
                    newAttributes.font = self.titleLabel?.font
                    return newAttributes
                }
                
                // Image
                if self.tintImageWithTitleColor, self.imageView != nil {
                    self.configuration?.imageColorTransformer = UIConfigurationColorTransformer { _ in
                        return self.titleColor(for: .selected) ?? self.titleColor(for: .normal) ?? self.configuration?.baseForegroundColor ?? UIColor.white
                    }
                }
                
            case .disabled:
                
                // Apperance
                let backgroundColor = self._disabledBackgroundColor ?? self._normalBackgroundColor
                self.backgroundColor = backgroundColor
                self.configuration?.baseBackgroundColor = backgroundColor
                self.layer.borderColor = self._disabledBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
                
                // Title
                self.configuration?.title = self._disabledTitle ?? self._normalTitle
                self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                    var newAttributes = attributes
                    newAttributes.foregroundColor = self.titleColor(for: .disabled)
                    newAttributes.font = self.titleLabel?.font
                    return newAttributes
                }
                
                // Image
                if self.tintImageWithTitleColor, let imageView = self.imageView, imageView.image != nil {
                    self.configuration?.imageColorTransformer = UIConfigurationColorTransformer { _ in
                        return self.titleColor(for: .disabled) ?? self.titleColor(for: .normal) ?? self.configuration?.baseForegroundColor ?? UIColor.white
                    }
                }
                
            default:
                
                // Do nothing
                break;
            }
        }
    }
    
    private func updateColors(updateImageTintColor:Bool)
    {
        if #available(iOS 15.0, *) {
            return
        }
        
        if self.isEnabled
        {
            if (self.isHighlighted)
            {
                self.backgroundColor = self._highlightedBackgroundColor ?? self._normalBackgroundColor
                self.layer.borderColor = self._highlightedBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
                if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
                    imageView.tintColor = self.titleColor(for: .highlighted)
                }
            }
            else if (self.isSelected)
            {
                self.backgroundColor = self._selectedBackgroundColor ?? self._normalBackgroundColor
                self.layer.borderColor = self._selectedBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
                if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
                    imageView.tintColor = self.titleColor(for: .selected)
                }
            }
            else
            {
                self.backgroundColor = self._normalBackgroundColor
                self.layer.borderColor = (self._normalBorderColor ?? UIColor.clear).cgColor
                if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
                    imageView.tintColor = self.titleColor(for: UIControl.State())
                }
            }
        }
        else
        {
            self.backgroundColor = self._disabledBackgroundColor ?? self._normalBackgroundColor
            self.layer.borderColor = self._disabledBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
            if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
                imageView.tintColor = self.titleColor(for: .disabled)
            }
        }
    }
    
    private func updateImageRenderingModeForState(_ state:UIControl.State) {
        let renderingMode = self.tintImageWithTitleColor ? UIImage.RenderingMode.alwaysTemplate : UIImage.RenderingMode.alwaysOriginal
        if let image = self.image(for: state), image.renderingMode != renderingMode {
            super.setImage(image.withRenderingMode(renderingMode), for: state)
        }
    }
}
