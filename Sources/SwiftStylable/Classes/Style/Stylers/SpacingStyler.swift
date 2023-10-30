//
//  Spacing.swift
//  SwiftStylable
//
//  Created by Rens Wijnmalen on 07/04/2020.
//

import Foundation

class SpacingStyler: Styler {
	
	private weak var _view: SpacingStylable?
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: SpacingStylable) {
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
		
        if let spacing = style.spacingStyle.spacing {
            view.spacingValue = spacing
        }
        
        if let imagePadding = style.spacingStyle.imagePadding {
            view.imagePadding = imagePadding
        }
        
	}
}
