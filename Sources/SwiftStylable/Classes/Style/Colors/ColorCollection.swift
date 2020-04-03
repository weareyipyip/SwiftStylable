//
//  ColorCollection.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 21/09/2018.
//

import UIKit

public class ColorCollection {

    private var _colorHolders = [String:ColorHolder]()

    
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
    
    internal func applyData(_ data:[String:String]) {
        var colorEntries = data
        var numParsedColors = 1
        while colorEntries.count > 0 && numParsedColors > 0 {
            numParsedColors = 0
            for (name, colorString) in colorEntries {
                if let color = UIColor(hexString: colorString) {
                    if let colorHolder = self._colorHolders[name] {
                        colorHolder.reference = nil
                        colorHolder.color = color
                    } else {
                        self._colorHolders[name] = ColorHolder(color: color)
                    }
                    colorEntries.removeValue(forKey: name)
                    numParsedColors += 1
                } else if let colorHolder = self._colorHolders[colorString] {
                    self._colorHolders[name] = ColorHolder(reference: colorHolder)
                    colorEntries.removeValue(forKey: name)
                    numParsedColors += 1
                }
            }
        }
        if colorEntries.count > 0 {
            // Not everything was parsed in the above code, this means there are unsatifyable colorStrings
            print("WARNING: not all colors could be parsed, this probably means a name is used, but no actual color is ever assigned to it")
        }
    }
    
    internal func colorHolderNamed(_ name:String)->ColorHolder? {
        return self._colorHolders[name]
    }
}
