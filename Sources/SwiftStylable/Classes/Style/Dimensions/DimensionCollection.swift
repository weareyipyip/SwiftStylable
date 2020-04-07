//
//  DimensionCollection.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 04/02/2019.
//

import UIKit

public class DimensionCollection {
    
    private var _dimensionHolders = [String:DimensionHolder]()
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal func applyData(_ data:[String:Any]) {
        var dimensionsEntries = data
        var numParsedDimensions = 1
        while dimensionsEntries.count > 0 && numParsedDimensions > 0 {
            numParsedDimensions = 0
            for (name, dimensionValue) in dimensionsEntries {
                if let size = dimensionValue as? CGFloat {
                    if let dimensionHolder = self._dimensionHolders[name] {
                        dimensionHolder.reference = nil
                        dimensionHolder.size = size
                    } else {
                        self._dimensionHolders[name] = DimensionHolder(size: size)
                    }
                    dimensionsEntries.removeValue(forKey: name)
                    numParsedDimensions += 1
                } else if let parentString = dimensionValue as? String, let dimensionHolder = self._dimensionHolders[parentString] {
                    if let existingHolder = self._dimensionHolders[name] {
                        existingHolder.reference = dimensionHolder
                    } else {
                        self._dimensionHolders[name] = DimensionHolder(reference: dimensionHolder)
                    }
                    dimensionsEntries.removeValue(forKey: name)
                    numParsedDimensions += 1
                }
            }
        }
        if dimensionsEntries.count > 0 {
            // Not everything was parsed in the above code, this means there are unsatifyable dimensionStrings
            print("WARNING: not all dimensions could be parsed, this probably means a name is used, but no actual dimension is ever assigned to it")
        }
    }
    
    internal func dimensionHolderNamed(_ name:String) -> DimensionHolder? {
        return self._dimensionHolders[name]
    }
}
