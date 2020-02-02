//
//  ForegroundStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class ForegroundStyle : StyleSetBase {
    
    public private(set) var foregroundColor:UIColor?
    public private(set) var highlightedForegroundColor:UIColor?
    public private(set) var selectedForegroundColor:UIColor?
    public private(set) var disabledForegroundColor:UIColor?
    
    private let _parent:ForegroundStyle?
    
    private var _foregroundColorName:String?
    private var _highlightedForegroundColorName:String?
    private var _selectedForegroundColorName:String?
    private var _disabledForegroundColorName:String?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:ForegroundStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    var foregroundColorName:String? {
        return self._foregroundColorName ?? self._parent?.foregroundColorName
    }
    
    var highlightedForegroundColorName:String? {
        return self._highlightedForegroundColorName ?? self._parent?.highlightedForegroundColorName
    }
    
    var selectedForegroundColorName:String? {
        return self._selectedForegroundColorName ?? self._parent?.selectedForegroundColorName
    }
    
    var disabledForegroundColorName:String? {
        return self._disabledForegroundColorName ?? self._parent?.disabledForegroundColorName
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let foregroundColorString = data["foregroundColor"] as? String {
            self._foregroundColorName = foregroundColorString
        }
        if let highlightedForegroundColorString = data["highlightedForegroundColor"] as? String {
            self._highlightedForegroundColorName = highlightedForegroundColorString
        }
        if let selectedForegroundColorString = data["selectedForegroundColor"] as? String {
            self._selectedForegroundColorName = selectedForegroundColorString
        }
        if let disabledForegroundColorString = data["disabledForegroundColor"] as? String {
            self._disabledForegroundColorName = disabledForegroundColorString
        }
    }
    
    override internal func update() {
        super.update()
        
        self.foregroundColor = self.colorFromString(self.foregroundColorName)
        self.highlightedForegroundColor = self.colorFromString(self.highlightedForegroundColorName)
        self.selectedForegroundColor = self.colorFromString(self.selectedForegroundColorName)
        self.disabledForegroundColor = self.colorFromString(self.disabledForegroundColorName)
    }
}
