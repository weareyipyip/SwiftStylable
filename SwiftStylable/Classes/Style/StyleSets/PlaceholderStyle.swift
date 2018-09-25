//
//  PlaceholderStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class PlaceholderStyle : StyleSetBase {
    
    public private(set) var fullUppercasePlaceholder:Bool?
    public private(set) var styledPlaceholderAttributes:[NSAttributedString.Key:Any]?
    
    private let _parent:PlaceholderStyle?

    private var _fullUppercasePlaceholder:Bool?
    private var _styledPlaceholderDictionary:[String:Any]?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:PlaceholderStyle? = nil, data:[String:Any], colorCollection:ColorCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection)
        self.applyData(data)
    }
    

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let styledPlaceholderDictionary = data["styledPlaceholderAttributes"] as? [String:Any] {
            self._styledPlaceholderDictionary = styledPlaceholderDictionary
        }
        if let fullUppercasePlaceholder = data["fullUppercasePlaceholder"] as? Bool {
            self._fullUppercasePlaceholder = fullUppercasePlaceholder
        }
    }
    
    override internal func update() {
        super.update()
        
        self.fullUppercasePlaceholder = self._fullUppercasePlaceholder ?? self._parent?.fullUppercasePlaceholder
        self.styledPlaceholderAttributes = self.stringAttributesFromDictionary(self._styledPlaceholderDictionary) ?? self._parent?.styledPlaceholderAttributes
    }
}
