//
//  TextBorderStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class TextBorderStyle : StyleSetBase {
    
    public private(set) var borderStyle:UITextField.BorderStyle?
    
    private let _parent:TextBorderStyle?
    
    private var _borderStyle:UITextField.BorderStyle?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:TextBorderStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let borderStyle = data["borderStyle"] as? String {
            switch borderStyle {
            case "none":
                self._borderStyle = UITextField.BorderStyle.none
                
            case "line":
                self._borderStyle = UITextField.BorderStyle.line

            case "bezel":
                self._borderStyle = UITextField.BorderStyle.bezel

            case "roundedRect":
                self._borderStyle = UITextField.BorderStyle.roundedRect

            default:
                break
            }
        }
    }
    
    override internal func update() {
        super.update()
        self.borderStyle = self._borderStyle ?? self._parent?.borderStyle
    }
}
