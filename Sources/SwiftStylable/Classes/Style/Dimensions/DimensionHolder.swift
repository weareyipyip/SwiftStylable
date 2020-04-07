//
//  DimensionHolder.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 04/02/2019.
//

import UIKit

open class DimensionHolder {
    
    var reference: DimensionHolder?
    
    var _size: CGFloat?
    var size: CGFloat {
        set {
            self._size = newValue
        }
        get {
            if let reference = self.reference {
                return reference.size
            }
            
            if let size = self._size {
                return size
            }
            
            print("WARNING: one of the DimensionHolder objects has no reference or size property set, the default value 0 will be retunred")
            return 0
        }
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(size: CGFloat) {
        self._size = size
    }
    
    init(reference: DimensionHolder) {
        self.reference = reference
    }
}
