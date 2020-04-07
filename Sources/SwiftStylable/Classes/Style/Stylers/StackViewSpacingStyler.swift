//
//  StackViewSpacing.swift
//  SwiftStylable
//
//  Created by Rens Wijnmalen on 07/04/2020.
//

import Foundation

class StackViewSpacingStyler: Styler {
	
	private weak var _view: StackViewSpacingStylable?
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: StackViewSpacingStylable) {
		self._view = view
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	open func applyStyle(_ style: Style) {
		
		guard let view = self._view else {
			return
		}
		
        if let spacing = style.stackViewSpacingStyle.stackViewSpacing {
            view.stackViewSpacing = spacing
        }
	}
}
