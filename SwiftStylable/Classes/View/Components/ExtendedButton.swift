//
//  ExtendedButton.swift
//  YipYipSwift
//
//  Created by Marcel Bloemendaal on 08/01/15.
//  Copyright (c) 2015 Marcel Bloemendaal. All rights reserved.
//

import Foundation
import UIKit

open class ExtendedButton: UIButton {
    private var _normalBackgroundColor:UIColor = UIColor.black
    private var _highlightedBackgroundColor:UIColor?
    private var _selectedBackgroundColor:UIColor?
    private var _disabledBackgroundColor:UIColor?
    
    private var _normalBorderColor:UIColor = UIColor.clear
    private var _highlightedBorderColor:UIColor?
    private var _selectedBorderColor:UIColor?
    private var _disabledBorderColor:UIColor?
    
    private var _normalTitle:String?
    private var _highlightedTitle:String?
    private var _selectedTitle:String?
    private var _disabledTitle:String?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._normalTitle = super.title(for: .normal)
        self._highlightedTitle = super.title(for: .highlighted)
        self._selectedTitle = super.title(for: .selected)
        self._disabledTitle = super.title(for: .disabled)
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable open var placeImageOnTheRight:Bool = false	{
        didSet {
            if self.placeImageOnTheRight {
                self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            } else {
                self.transform = CGAffineTransform.identity
                self.titleLabel?.transform = CGAffineTransform.identity
                self.imageView?.transform = CGAffineTransform.identity
            }
        }
    }
    
    override open var isHighlighted:Bool {
        get	{
            return super.isHighlighted
        }
        set(value) {
            super.isHighlighted = value
            self.updateColors()
        }
    }
    
    override open var isSelected:Bool {
        get	{
            return super.isSelected
        }
        set(value) {
            super.isSelected = value
            self.updateColors()
        }
    }
    
    override open var isEnabled:Bool {
        get	{
            return super.isEnabled
        }
        set(value) {
            super.isEnabled = value
            self.updateColors()
        }
    }
    
    @IBInspectable open var tintImageWithTitleColor:Bool = false {
        didSet {
            if self.tintImageWithTitleColor != oldValue {
                self.updateImageRenderingModeForState(UIControlState())
                self.updateImageRenderingModeForState(.highlighted)
                self.updateImageRenderingModeForState(.selected)
                self.updateImageRenderingModeForState(.disabled)
            }
            self.updateColors()
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
    
    open func setBackgroundColor(_ color:UIColor, forState:UIControlState)
    {
        switch (forState)
        {
        case UIControlState():
            _normalBackgroundColor = color
            break
            
        case UIControlState.highlighted:
            _highlightedBackgroundColor = color
            break
            
        case UIControlState.selected:
            _selectedBackgroundColor = color
            break
            
        case UIControlState.disabled:
            _disabledBackgroundColor = color
            break
            
        default:
            break;
        }
        self.updateColors()
    }
    
    open func setBorderColor(_ color:UIColor, forState:UIControlState)
    {
        switch (forState)
        {
        case UIControlState():
            _normalBorderColor = color
            break
            
        case UIControlState.highlighted:
            _highlightedBorderColor = color
            break
            
        case UIControlState.selected:
            _selectedBorderColor = color
            break
            
        case UIControlState.disabled:
            _disabledBorderColor = color
            break
            
        default:
            break
        }
        self.updateColors()
    }
	
	open override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
		super.setTitleColor(color, for: state)
		self.updateColors()
	}
    
    open override func setImage(_ image: UIImage?, for state: UIControlState) {
        super.setImage(image, for: state)
        self.updateImageRenderingModeForState(state)
        self.updateColors()
    }
    
    open override func setTitle(_ title: String?, for state: UIControlState) {
        switch state {
        case UIControlState.normal:
            self._normalTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        case UIControlState.highlighted:
            self._highlightedTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        case UIControlState.selected:
            self._selectedTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        case UIControlState.disabled:
            self._disabledTitle = title
            super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
            
        default:
            super.setTitle(title, for: state)
        }
    }
    
    open override func title(for state: UIControlState)->String? {
        switch state {
        case UIControlState.normal:
            return self._normalTitle
            
        case UIControlState.highlighted:
            return self._highlightedTitle
            
        case UIControlState.selected:
            return self._selectedTitle
            
        case UIControlState.disabled:
            return self._disabledTitle
            
        default:
            return super.title(for: state)
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    fileprivate func updateColors()
    {
        if self.isEnabled
        {
            if (self.isHighlighted)
            {
                self.backgroundColor = self._highlightedBackgroundColor ?? self._normalBackgroundColor
                self.layer.borderColor = self._highlightedBorderColor?.cgColor ?? self._normalBorderColor.cgColor
                self.imageView?.tintColor = self.titleColor(for: .highlighted)
            }
            else if (self.isSelected)
            {
                self.backgroundColor = self._selectedBackgroundColor ?? self._normalBackgroundColor
                self.layer.borderColor = self._selectedBorderColor?.cgColor ?? self._normalBorderColor.cgColor
                self.imageView?.tintColor = self.titleColor(for: .selected)
            }
            else
            {
                self.backgroundColor = self._normalBackgroundColor
                self.layer.borderColor = self._normalBorderColor.cgColor
                self.imageView?.tintColor = self.titleColor(for: UIControlState())
            }
        }
        else
        {
            self.backgroundColor = self._disabledBackgroundColor ?? self._normalBackgroundColor
            self.layer.borderColor = self._disabledBorderColor?.cgColor ?? self._normalBorderColor.cgColor
            self.imageView?.tintColor = self.titleColor(for: .disabled)
        }
    }
    
    fileprivate func updateImageRenderingModeForState(_ state:UIControlState) {
        if let image = self.image(for: state) {
            let renderingMode = self.tintImageWithTitleColor ? UIImageRenderingMode.alwaysTemplate : UIImageRenderingMode.alwaysOriginal
            super.setImage(image.withRenderingMode(renderingMode), for: state)
        }
    }
}
