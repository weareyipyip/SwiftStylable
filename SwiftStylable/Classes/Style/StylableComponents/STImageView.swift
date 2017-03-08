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
			if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
				self.applyStyle(style)
			}
		}
	}
	
	@IBInspectable open var imageName:String? {
        didSet {
            if let imageName = self.imageName, let helper = STHelper.sharedHelper as? SwiftStylableHelper {
                self.image = helper.imageNamed(imageName)
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
		if let tintImageWithForegroundColor = style.tintImageWithForegroundColor {
			self.tintImageWithForegroundColor = tintImageWithForegroundColor
		}
		if let foregroundColor = style.foregroundColor {
			self.tintColor = foregroundColor
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
