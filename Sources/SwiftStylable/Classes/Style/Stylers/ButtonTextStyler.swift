//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class ButtonTextStyler : Styler {
	
	private weak var _view: ButtonTextStylable?
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: ButtonTextStylable) {
		self._view = view
	}

	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	open func applyStyle(_ style:Style) {
		
		guard let view = self._view else {
			return
		}
		
		// Text
		if let font = style.textStyle.font {
            if let textFontStyle = style.textStyle.fontTextStyle {
                view.titleLabel?.font = UIFontMetrics(forTextStyle: textFontStyle).scaledFont(for: font)
            } else {
                view.titleLabel?.font = font
            }
		}
		if let fullUppercaseText = style.textStyle.fullUppercaseText {
			view.fullUppercaseText = fullUppercaseText
		}
	}
}
