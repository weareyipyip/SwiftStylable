//
//  ColorHolder.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 30/04/2018.
//

import UIKit

class ColorHolder {
    
    internal private(set) var reference: ColorHolder?
    
    private var _color: UIColor?
    internal var color: UIColor {
        if let reference = self.reference {
            return reference.color
        }
        
        if let color = self._color {
            return color
        }
        
        print("WARNING: one of the ColorHolder objects has no reference or color property set, the default color black will be retunred")
        return .black
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(color: UIColor) {
        self._color = color
    }
    
    init(reference: ColorHolder) {
        self.reference = reference
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Setter methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal func set(with color: UIColor) {
        self.reference = nil
        self._color = color
    }
    
    internal func set(with reference: ColorHolder) {
        self.reference = reference
        self._color = nil
    }
}
