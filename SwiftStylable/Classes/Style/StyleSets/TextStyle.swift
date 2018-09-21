//
//  TextStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class TextStyle : StyleSetBase {
    
    public private(set) var font:UIFont?
    public private(set) var fullUppercaseText:Bool?
    
    private let _parent:TextStyle?
    
    private var _fontName:String?
    private var _fontSize:CGFloat?
    private var _fullUppercaseText:Bool?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:TextStyle? = nil, data:[String:Any]) {
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
        
        if let font = data["font"] as? [String:Any] {
            if let name = font["name"] as? String {
                self._fontName = name
            }
            if let sizeAny = font["size"] {
                if let size = sizeAny as? CGFloat {
                    self._fontSize = size
                } else {
                    print("WARNING: Style definition for '\(self.name)' has a font size of type String, change to a Number in the styles.plist")
                }
            }
        }
        if let fullUppercaseText = data["fullUppercaseText"] as? Bool {
            self._fullUppercaseText = fullUppercaseText
        }
    }
    
    override internal func update() {
        super.update()
        
        let parentFont = self._parent?.font
        if let name = self._fontName ?? parentFont?.fontName,
            let size = self._fontSize ?? parentFont?.pointSize, let font = UIFont(name: name, size: size) {
            self.font = font
        } else {
            self.font = nil
        }
        self.fullUppercaseText = self._fullUppercaseText ?? self._parent?.fullUppercaseText
    }
}
