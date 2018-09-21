//
//  ForegroundStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class ForegroundStyle : StyleSetBase {
    
    public private(set) var foregroundColor:UIColor?
    public private(set) var highlightedForegroundColor:UIColor?
    public private(set) var selectedForegroundColor:UIColor?
    public private(set) var disabledForegroundColor:UIColor?
    
    private let _parent:ForegroundStyle?
    
    private var _foregroundColorString:String?
    private var _highlightedForegroundColorString:String?
    private var _selectedForegroundColorString:String?
    private var _disabledForegroundColorString:String?
    

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:ForegroundStyle? = nil, data:[String:Any]) {
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
        
        if let foregroundColorString = data["foregroundColor"] as? String {
            self._foregroundColorString = foregroundColorString
        }
        if let highlightedForegroundColorString = data["highlightedForegroundColor"] as? String {
            self._highlightedForegroundColorString = highlightedForegroundColorString
        }
        if let selectedForegroundColorString = data["selectedForegroundColor"] as? String {
            self._selectedForegroundColorString = selectedForegroundColorString
        }
        if let disabledForegroundColorString = data["disabledForegroundColor"] as? String {
            self._disabledForegroundColorString = disabledForegroundColorString
        }
    }
    
    override internal func update() {
        super.update()
        
        self.foregroundColor = self.colorFromString(self._foregroundColorString) ?? self._parent?.foregroundColor
        self.highlightedForegroundColor = self.colorFromString(self._highlightedForegroundColorString) ?? self._parent?.highlightedForegroundColor
        self.selectedForegroundColor = self.colorFromString(self._highlightedForegroundColorString) ?? self._parent?.selectedForegroundColor
        self.disabledForegroundColor = self.colorFromString(self._disabledForegroundColorString) ?? self._parent?.disabledForegroundColor
    }
}
