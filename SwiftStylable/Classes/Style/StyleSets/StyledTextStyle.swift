//
//  StyledTextStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class StyledTextStyle : StyleSetBase {
    
    public private(set) var styledTextAttributes:[NSAttributedString.Key:Any]?
    
    private let _parent:StyledTextStyle?

    private var _styledTextDictionary:[String:Any]?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:StyledTextStyle? = nil, data:[String:Any]) {
        self._parent = parent
        super.init(name: name, parent: parent)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let styledTextDictionary = data["styledTextAttributes"] as? [String:Any] {
            self._styledTextDictionary = styledTextDictionary
        }
    }
    
    override internal func update() {
        super.update()
        
        self.styledTextAttributes = self.stringAttributesFromDictionary(self._styledTextDictionary) ?? self._parent?.styledTextAttributes
    }
}
