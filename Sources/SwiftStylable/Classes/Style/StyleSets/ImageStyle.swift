//
//  ImageStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 21/09/2018.
//

import Foundation

public class ImageStyle : StyleSetBase {
    
    public private(set) var tintImageWithForegroundColor:Bool?
    
    private let _parent:ImageStyle?
    
    private var _tintImageWithForegroundColor:Bool?
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:ImageStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal var tintImageWithForegroundColorValue: Bool? {
        return self._tintImageWithForegroundColor ?? self._parent?.tintImageWithForegroundColorValue
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let tintImageWithForegroundColor = data["tintImageWithForegroundColor"] as? Bool {
            self._tintImageWithForegroundColor = tintImageWithForegroundColor
        }
    }
    
    override internal func update() {
        super.update()
        self.tintImageWithForegroundColor = self.tintImageWithForegroundColorValue
    }
}
