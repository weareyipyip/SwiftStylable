//
//  TextStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class TextStyle : StyleSetBase {
    
    public private(set) var font:UIFont?
    public private(set) var fullUppercaseText:Bool?
    
    private let _parent:TextStyle?
    
    private var _fontName:String?
    private var _fontSizeDescription:Any?
    private var _fullUppercaseText:Bool?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:TextStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    var fontName:String? {
        get {
            return self._fontName ?? self._parent?.fontName
        }
    }
    
    var fontSizeValue:Any? {
        get {
            return self._fontSizeDescription ?? self._parent?.fontSizeValue
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let font = data["font"] as? [String:Any] {
            if let name = font["name"] as? String {
                self._fontName = name
            }
            self._fontSizeDescription = font["size"]
        }
        if let fullUppercaseText = data["fullUppercaseText"] as? Bool {
            self._fullUppercaseText = fullUppercaseText
        }
    }
    
    override internal func update() {
        super.update()
        
        if let fontSize = self.dimensionFromValue(self.fontSizeValue){
            self.font = self.createFont(name: self.fontName, size: fontSize)
        }
        self.fullUppercaseText = self._fullUppercaseText ?? self._parent?.fullUppercaseText
    }
}
