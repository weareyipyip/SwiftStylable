//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class ForegroundStyler : Styler {
	
	private weak var _view: ForegroundStylable?
	private var _canBeHighlighted:Bool
	private var _canBeSelected:Bool
	private var _canBeDisabled:Bool

	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: ForegroundStylable, canBeHighlighted:Bool = false, canBeSelected:Bool = false, canBeDisabled:Bool = false) {
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
		
		if let foregroundColor = style.foregroundStyle.foregroundColor {
			view.foregroundColor = foregroundColor
		}
		
		if self._canBeHighlighted {
			if let highlightedForegroundColor = style.foregroundStyle.highlightedForegroundColor {
				view.highlightedForegroundColor = highlightedForegroundColor
			}
		}
		if self._canBeSelected {
			if let selectedForegroundColor = style.foregroundStyle.selectedForegroundColor {
				view.selectedForegroundColor = selectedForegroundColor
			}
		}
		
		if self._canBeDisabled {
			if let disabledForegroundColor = style.foregroundStyle.disabledForegroundColor {
				view.disabledForegroundColor = disabledForegroundColor
			}
		}
	}
}
