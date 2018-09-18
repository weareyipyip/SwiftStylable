//
//  PlaceholderTextStylePropertySet.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import Foundation

class PlaceholderTextStylePropertySet : StylePropertySet {
    
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
    
    open func applyStyle(_ style:Style) {
        
        guard let view = self._view else {
            return
        }
        
        if let fullUppercasePlaceholder = style.fullUppercasePlaceholder {
            view.fullUppercasePlaceholder = fullUppercasePlaceholder
        }
        if let styledPlaceholderAttributes = style.styledPlaceholderAttributes {
            view.styledPlaceholderAttributes = styledPlaceholderAttributes
        }
    }
}
