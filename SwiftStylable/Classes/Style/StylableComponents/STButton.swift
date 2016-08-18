//
//  STButton.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation


@IBDesignable public class STButton : ExtendedButton, Stylable {
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable public var styleName:String? {
        didSet {
            #if !TARGET_INTERFACE_BUILDER
                if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                    self.applyStyle(style)
                }
            #endif
        }
    }
    
    @IBInspectable public var imageName:String? {
        didSet {
            self.processImageName(self.imageName, forState: .Normal)
        }
    }
    
    @IBInspectable public var highlightedImageName:String? {
        didSet {
            self.processImageName(self.highlightedImageName, forState: .Highlighted)
        }
    }
    
    @IBInspectable public var selectedImageName:String? {
        didSet {
            self.processImageName(self.selectedImageName, forState: .Selected)
        }
    }
    
    @IBInspectable public var disabledImageName:String? {
        didSet {
            self.processImageName(self.disabledImageName, forState: .Disabled)
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public func applyStyle(style:Style) {
        self.setBackgroundColor(style.backgroundColor, forState: .Normal)
        self.setBackgroundColor(style.highlightedBackgroundColor, forState: .Highlighted)
        self.setBackgroundColor(style.selectedBackgroundColor, forState: .Selected)
        self.setBackgroundColor(style.disabledBackgroundColor, forState: .Disabled)
        
        self.setBorderColor(style.borderColor, forState: .Normal)
        self.setBorderColor(style.highlightedBorderColor, forState: .Highlighted)
        self.setBorderColor(style.selectedBorderColor, forState: .Selected)
        self.setBorderColor(style.disabledBorderColor, forState: .Disabled)
        
        self.setTitleColor(style.foregroundColor, forState: .Normal)
        self.setTitleColor(style.highlightedForegroundColor, forState: .Highlighted)
        self.setTitleColor(style.selectedForegroundColor, forState: .Selected)
        self.setTitleColor(style.disabledForegroundColor, forState: .Disabled)
        
        self.titleLabel?.font = style.font
        
        self.layer.cornerRadius = style.cornerRadius
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
            self.applyStyle(style)
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func processImageName(imageName:String?, forState state: UIControlState) {
        if let name = imageName, helper = STHelper.sharedHelper as? SwiftStylableHelper, image = helper.imageNamed(name) {
            self.setImage(image, forState: state)
        } else {
            self.setImage(nil, forState: state)
        }
    }
}
