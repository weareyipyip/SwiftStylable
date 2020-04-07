//
//  DimensionHolder.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 04/02/2019.
//

import UIKit

open class DimensionHolder {
    
    internal private(set) var reference: DimensionHolder?
    
    private var _size: CGFloat?
    internal var size: CGFloat {
        if let reference = self.reference {
            return reference.size
        }
        
        if let size = self._size {
            return size
        }
        
        print("WARNING: one of the DimensionHolder objects has no reference or size property set, the default value 0 will be retunred")
        return 0
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
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Setter methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal func set(with size: CGFloat) {
        self.reference = nil
        self._size = size
    }
    
    internal func set(with reference: DimensionHolder) {
        self.reference = reference
        self._size = nil
    }
}
