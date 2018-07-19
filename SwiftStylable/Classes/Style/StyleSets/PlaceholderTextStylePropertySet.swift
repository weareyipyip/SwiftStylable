//
//  PlaceholderTextStylePropertySet.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import Foundation

class PlaceholderTextStylePropertySet : StylePropertySet {
    
    private weak var _view: PlaceholderTextStylable?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(_ view: PlaceholderTextStylable) {
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
        
        if let placeholder = view.placeholder {
            let attributedPlaceholderString = NSMutableAttributedString(string: placeholder)
            
            if let font = style.placeholderFont {
                attributedPlaceholderString.addAttribute(.font, value: font, range: NSRange(location: 0, length: placeholder.count))
            }
            
            if let color = style.placeholderColor {
                attributedPlaceholderString.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: placeholder.count))
            }
            
            view.attributedPlaceholderString = attributedPlaceholderString
        }
    }
}
