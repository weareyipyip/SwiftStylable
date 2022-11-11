//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class StyledTextStyler : Styler {
    
    private weak var _view: StyledTextStylable?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(_ view: StyledTextStylable) {
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
        
        if let styledTextAttributes = style.styledTextStyle.styledTextAttributes {
            if view.styledTextAttributes != nil {
                styledTextAttributes.keys.forEach({ view.styledTextAttributes![$0] = styledTextAttributes[$0] })
            } else {
                view.styledTextAttributes = styledTextAttributes
            }
        }
    }
}
