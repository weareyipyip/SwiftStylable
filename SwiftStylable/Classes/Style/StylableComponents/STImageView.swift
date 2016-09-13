//
//  STImageView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable public class STImageView : UIImageView, Stylable {
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Computed properties
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	@IBInspectable public var styleName:String? {
		didSet {
			if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
				self.applyStyle(style)
			}
		}
	}
	
	@IBInspectable public var imageName:String? {
        didSet {
            if let imageName = self.imageName, helper = STHelper.sharedHelper as? SwiftStylableHelper {
                self.image = helper.imageNamed(imageName)
            } else {
                self.image = nil
            }
        }
    }
	
	@IBInspectable public var tintImageWithForegroundColor = false {
		didSet {
			if self.tintImageWithForegroundColor != oldValue {
				self.updateImageRenderingMode()
			}
		}
	}
	
	public override var image: UIImage? {
		didSet {
			self.updateImageRenderingMode()
		}
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	public func applyStyle(style:Style) {
		self.tintImageWithForegroundColor = style.tintImageWithForegroundColor
		self.tintColor = style.foregroundColor
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private func updateImageRenderingMode() {
		if let image = self.image {
			let renderingMode = self.tintImageWithForegroundColor ? UIImageRenderingMode.AlwaysTemplate : UIImageRenderingMode.AlwaysOriginal
			super.image = image.imageWithRenderingMode(renderingMode)
		}
	}
}