//
//  STImageView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STImageView : UIImageView, Stylable {
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: - Initializers & deinit
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		NotificationCenter.default.addObserver(self, selector: #selector(STImageView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
		NotificationCenter.default.addObserver(self, selector: #selector(STImageView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
	}
	
	public override init(image: UIImage?) {
		super.init(image: image)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Computed properties
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	@IBInspectable open var styleName:String? {
		didSet {
			self.updateStyles()
		}
	}
	
	@IBInspectable open var substyleName:String? {
		didSet {
			self.updateStyles()
		}
	}
	
	@IBInspectable open var imageName:String? {
        didSet {
            if let imageName = self.imageName {
                self.image = self.paintCodeImageNamed(imageName)
            } else {
                self.image = nil
            }
        }
    }
	
	@IBInspectable open var tintImageWithForegroundColor = false {
		didSet {
			if self.tintImageWithForegroundColor != oldValue {
				self.updateImageRenderingMode()
			}
		}
	}
	
	open override var image: UIImage? {
		didSet {
			self.updateImageRenderingMode()
		}
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	open func applyStyle(_ style:Style) {
        if let backgroundColor = style.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let borderWidth = style.borderWidth {
            self.layer.borderWidth = borderWidth
        }
        if let borderColor = style.borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        if let cornerRadius = style.cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        if let clipsToBounds = style.clipsToBounds {
            self.clipsToBounds = clipsToBounds
        }
		if let tintImageWithForegroundColor = style.tintImageWithForegroundColor {
			self.tintImageWithForegroundColor = tintImageWithForegroundColor
		}
		if let foregroundColor = style.foregroundColor {
			self.tintColor = foregroundColor
		}
	}
    
    open func paintCodeImageNamed(_ name:String)->UIImage? {
        return nil
    }
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: - Internal methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	@objc func stylesDidUpdate(_ notification:Notification) {
		self.updateStyles()
	}

	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	fileprivate func updateImageRenderingMode() {
		if let image = self.image {
			let renderingMode = self.tintImageWithForegroundColor ? UIImageRenderingMode.alwaysTemplate : UIImageRenderingMode.alwaysOriginal
			super.image = image.withRenderingMode(renderingMode)
		}
	}
}
