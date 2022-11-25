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
    public private(set) var fontTextStyleMaximumSize:CGFloat?
    
    private let _parent:PlaceholderStyle?

    private var _fullUppercasePlaceholder:Bool?
    private var _styledPlaceholderDictionary:[String:Any]?
    private var _fontTextStyle:UIFont.TextStyle?
    private var _fontTextStyleMaximumSizeDescription:Any?

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    var fontTextStyle:UIFont.TextStyle? {
        return self._fontTextStyle ?? self._parent?.fontTextStyle
    }
    
    var fontTextStyleMaximumSizeValue:Any? {
        return self._fontTextStyleMaximumSizeDescription ?? self._parent?.fontTextStyleMaximumSizeValue
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:PlaceholderStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
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
            if let font = styledPlaceholderDictionary["font"] as? [String:Any] {
                self._fontTextStyleMaximumSizeDescription = font["textStyleMaximumSize"]
                if
                    let rawTextStyleValue = font["textStyle"] as? String,
                    let textStyle = UIFont.TextStyle(rawStyleValue: rawTextStyleValue)
                {
                    self._fontTextStyle = textStyle
                }
            }
        }
        if let fullUppercasePlaceholder = data["fullUppercasePlaceholder"] as? Bool {
            self._fullUppercasePlaceholder = fullUppercasePlaceholder
        }
    }
    
    override internal func update() {
        super.update()
        
        self.fullUppercasePlaceholder = self._fullUppercasePlaceholder ?? self._parent?.fullUppercasePlaceholder
        self.styledPlaceholderAttributes = self.stringAttributesFromDictionary(self._styledPlaceholderDictionary) ?? self._parent?.styledPlaceholderAttributes
        
        if let fontTextStyleMaximumSize = self.dimensionFromValue(self.fontTextStyleMaximumSizeValue) {
            self.fontTextStyleMaximumSize = fontTextStyleMaximumSize
        }
    }
}
