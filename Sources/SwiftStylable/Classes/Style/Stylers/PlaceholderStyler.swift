//
//  PlaceholderTextStylePropertySet.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import Foundation

class PlaceholderTextStyler: Styler {
    
    private weak var _view: PlaceholderStylable?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(_ view: PlaceholderStylable) {
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
        
        if let styledPlaceholderAttributes = style.placeholderStyle.styledPlaceholderAttributes {
            if view.styledPlaceholderAttributes != nil {
                styledPlaceholderAttributes.keys.forEach({ view.styledPlaceholderAttributes![$0] = styledPlaceholderAttributes[$0] })
            } else {
                view.styledPlaceholderAttributes = styledPlaceholderAttributes
            }
        }
        
        if let fontTextStyle = style.placeholderStyle.fontTextStyle {
            view.styledPlaceholderFontStyle = fontTextStyle
        }
        
        if let fontTextStyleMaximumSize = style.placeholderStyle.fontTextStyleMaximumSize {
            view.styledPlaceholderFontStyleMaximumSize = fontTextStyleMaximumSize
        }
        
        if let fullUppercasePlaceholder = style.placeholderStyle.fullUppercasePlaceholder {
            view.fullUppercasePlaceholder = fullUppercasePlaceholder
        }
    }
}
