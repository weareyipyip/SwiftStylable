//
//  ColorHolder.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 30/04/2018.
//

import UIKit

class ColorHolder {
    
    var reference: ColorHolder?
    
    var _color: UIColor?
    var color: UIColor {
        set(newVal) {
            self._color = newVal
        }
        get {
            if let reference = self.reference {
                return reference.color
            }
            
            if let color = self._color {
                return color
            }
            
            print("WARNING: one of the ColorHolder objects has no reference or color property set, the default color black will be retunred")
            return .black
        }
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
}
