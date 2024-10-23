//
//  TextStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class TextStyle : StyleSetBase {
    
    public private(set) var font:UIFont?
    public private(set) var fontTextStyleMaximumSize:CGFloat?
    public private(set) var fullUppercaseText:Bool?
    
    private let _parent:TextStyle?
    
    private var _fontName:String?
    private var _fontSizeDescription:Any?
    private var _fontTextStyle:UIFont.TextStyle?
    private var _fontTextStyleMaximumSizeDescription:Any?
    private var _fontTextStyleAccessibilityBoldName:String?
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
    
    internal var fontName: String? {
        get {
            return self._fontName ?? self._parent?.fontName
        }
    }
    
    internal var fontSizeValue: Any? {
        get {
            return self._fontSizeDescription ?? self._parent?.fontSizeValue
        }
    }
    
    internal var fontTextStyleMaximumSizeValue: Any? {
        get {
            return self._fontTextStyleMaximumSizeDescription ?? self._parent?.fontTextStyleMaximumSizeValue
        }
    }
    
    public var fontTextStyle: UIFont.TextStyle? {
        get {
            return self._fontTextStyle ?? self._parent?.fontTextStyle
        }
    }
    
    internal var fontTextStyleAccessibilityBoldName:String? {
        get {
            return self._fontTextStyleAccessibilityBoldName ?? self._parent?.fontTextStyleAccessibilityBoldName
        }
    }
    
    public var dynamicFont: UIFont? {
        guard let fontTextStyle, let font else { return self.font }
        if let fontTextStyleMaximumSize {
            return UIFontMetrics(forTextStyle: fontTextStyle).scaledFont(for: font, maximumPointSize: fontTextStyleMaximumSize)
        } else {
            return UIFontMetrics(forTextStyle: fontTextStyle).scaledFont(for: font)
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
            self._fontTextStyleMaximumSizeDescription = font["textStyleMaximumSize"]
            self._fontTextStyleAccessibilityBoldName = font["accessibilityBoldName"] as? String
            
            if let rawTextStyleValue = font["textStyle"] as? String, let textStyle = UIFont.TextStyle(rawStyleValue: rawTextStyleValue) {
                self._fontTextStyle = textStyle
            }
        }
        if let fullUppercaseText = data["fullUppercaseText"] as? Bool {
            self._fullUppercaseText = fullUppercaseText
        }
    }
    
    override internal func update() {
        super.update()
        
        if let fontSize = self.dimensionFromValue(self.fontSizeValue){
            self.font = self.createFont(name: self.fontName, size: fontSize, accessibilityBoldName: self.fontTextStyleAccessibilityBoldName)
        }

        if let fontTextStyleMaximumSize = self.dimensionFromValue(self.fontTextStyleMaximumSizeValue) {
            self.fontTextStyleMaximumSize = fontTextStyleMaximumSize
        }
        
        self.fullUppercaseText = self._fullUppercaseText ?? self._parent?.fullUppercaseText
    }
}
