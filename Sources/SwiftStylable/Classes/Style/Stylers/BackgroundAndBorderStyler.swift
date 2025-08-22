//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class BackgroundAndBorderStyler : Styler {
	
	private weak var _view: BackgroundAndBorderStylable?
	private var _canBeHighlighted:Bool
	private var _canBeSelected:Bool
	private var _canBeDisabled:Bool
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: BackgroundAndBorderStylable, canBeHighlighted:Bool = false, canBeSelected:Bool = false, canBeDisabled:Bool = false) {
		self._view = view
		self._canBeHighlighted = canBeHighlighted
		self._canBeSelected = canBeSelected
		self._canBeDisabled = canBeDisabled
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

		if let backgroundColor = style.backgroundAndBorderStyle.backgroundColor {
			view.normalBackgroundColor = backgroundColor
		}
		if let borderWidth = style.backgroundAndBorderStyle.borderWidth {
			view.layer.borderWidth = borderWidth
		}
		if let borderColor = style.backgroundAndBorderStyle.borderColor {
			view.borderColor = borderColor
		}
		if let cornerRadius = style.backgroundAndBorderStyle.cornerRadius {
            view.layer.cornerRadius = cornerRadius
            if #available(iOS 15.0, *) {
                (view as? STButton)?.configuration?.background.cornerRadius = cornerRadius
            }
		}
		if let clipsToBounds = style.backgroundAndBorderStyle.clipsToBounds {
			view.clipsToBounds = clipsToBounds
		}
		
		if self._canBeHighlighted {
			if let highlightedBackgroundColor = style.backgroundAndBorderStyle.highlightedBackgroundColor {
				view.highlightedBackgroundColor = highlightedBackgroundColor
			}
			if let highlightedBorderColor = style.backgroundAndBorderStyle.highlightedBorderColor {
				view.highlightedBorderColor = highlightedBorderColor
			}
		}
		
		if self._canBeSelected {
			if let selectedBackgroundColor = style.backgroundAndBorderStyle.selectedBackgroundColor {
				view.selectedBackgroundColor = selectedBackgroundColor
			}
			if let selectedBorderColor = style.backgroundAndBorderStyle.selectedBorderColor {
				view.selectedBorderColor = selectedBorderColor
			}
		}
		
		if self._canBeDisabled {
			if let disabledBackgroundColor = style.backgroundAndBorderStyle.disabledBackgroundColor {
				view.disabledBackgroundColor = disabledBackgroundColor
			}
			if let disabledBorderColor = style.backgroundAndBorderStyle.disabledBorderColor {
				view.disabledBorderColor = disabledBorderColor
			}
		}
	}
}
