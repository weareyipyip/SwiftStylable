//
//  ButtonStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class BackgroundAndBorderStyle : StyleSetBase {
    
    public private(set) var clipsToBounds:Bool?
    public private(set) var borderWidth:CGFloat?
    public private(set) var cornerRadius:CGFloat?
    public private(set) var backgroundColor:UIColor?
    public private(set) var highlightedBackgroundColor:UIColor?
    public private(set) var selectedBackgroundColor:UIColor?
    public private(set) var disabledBackgroundColor:UIColor?
    public private(set) var borderColor:UIColor?
    public private(set) var highlightedBorderColor:UIColor?
    public private(set) var selectedBorderColor:UIColor?
    public private(set) var disabledBorderColor:UIColor?
    
    private let _parent:BackgroundAndBorderStyle?
    
    private var _borderWidthValue:Any?
    private var _cornerRadiusValue:Any?
    private var _clipsToBounds: Bool?
    
    // Background color names
    private var _backgroundColorName: String?
    private var _highlightedBackgroundColorName: String?
    private var _selectedBackgroundColorName: String?
    private var _disabledBackgroundColorName: String?
    
    // Border color names
    private var _borderColorName: String?
    private var _highlightedBorderColorName: String?
    private var _selectedBorderColorName: String?
    private var _disabledBorderColorName: String?
    
    // Caches
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required internal init(name:String, parent:BackgroundAndBorderStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection:DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    var backgroundColorName:String? {
        return self._backgroundColorName ?? self._parent?.backgroundColorName
    }
    
    var highlightedBackgroundColorName:String? {
        return self._highlightedBackgroundColorName ?? self._parent?.highlightedBackgroundColorName
    }
    
    var selectedBackgroundColorName:String? {
        return self._selectedBackgroundColorName ?? self._parent?.selectedBackgroundColorName
    }
    
    var disabledBackgroundColorName:String? {
        return self._disabledBackgroundColorName ?? self._parent?.disabledBackgroundColorName
    }
    
    var borderColorName:String? {
        return self._borderColorName ?? self._parent?.borderColorName
    }
    
    var highlightedBorderColorName:String? {
        return self._highlightedBorderColorName ?? self._parent?.highlightedBorderColorName
    }
    
    var selectedBorderColorName:String? {
        return self._selectedBorderColorName ?? self._parent?.selectedBorderColorName
    }
    
    var disabledBorderColorName:String? {
        return self._disabledBorderColorName ?? self._parent?.disabledBorderColorName
    }
    
    var borderWidthDescription:Any? {
        return self._borderWidthValue ?? self._parent?._borderWidthValue
    }
    
    var cornerRadiusDescription:Any? {
        return self._cornerRadiusValue ?? self._parent?._cornerRadiusValue
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        
        super._applyData(data)
        
        // Background colors
        if let backgroundColorString = data["backgroundColor"] as? String {
            self._backgroundColorName = backgroundColorString
        }
        if let highlightedBackgroundColorString = data["highlightedBackgroundColor"] as? String {
            self._highlightedBackgroundColorName = highlightedBackgroundColorString
        }
        if let selectedBackgroundColorString = data["selectedBackgroundColor"] as? String {
            self._selectedBackgroundColorName = selectedBackgroundColorString
        }
        if let disabledBackgroundColorString = data["disabledBackgroundColor"] as? String {
            self._disabledBackgroundColorName = disabledBackgroundColorString
        }
        
        // Border colors
        if let borderColorString = data["borderColor"] as? String {
            self._borderColorName = borderColorString
        }
        if let highlightedBorderColorString = data["highlightedBorderColor"] as? String {
            self._highlightedBorderColorName = highlightedBorderColorString
        }
        if let selectedBorderColorString = data["selectedBorderColor"] as? String {
            self._selectedBorderColorName = selectedBorderColorString
        }
        if let disabledBorderColorString = data["disabledBorderColor"] as? String {
            self._disabledBorderColorName = disabledBorderColorString
        }
        
        // Other
        self._cornerRadiusValue = data["cornerRadius"]
        self._borderWidthValue = data["borderWidth"]
        
        if let clipsToBounds = data["clipsToBounds"] as? Bool {
            self._clipsToBounds = clipsToBounds
        }
        
        NotificationCenter.default.post(name: StyleSetBase.didChangeNotification, object: self)
    }
    
    override internal func update() {
        super.update()
        
        self.clipsToBounds = self._clipsToBounds ?? self._parent?._clipsToBounds
        
        self.borderWidth = self.dimensionFromValue(self.borderWidthDescription)
        self.cornerRadius = self.dimensionFromValue(self.cornerRadiusDescription)
        
        self.backgroundColor = self.colorFromString(self.backgroundColorName)
        self.highlightedBackgroundColor = self.colorFromString(self.highlightedBackgroundColorName)
        self.selectedBackgroundColor = self.colorFromString(self.selectedBackgroundColorName)
        self.disabledBackgroundColor = self.colorFromString(self.disabledBackgroundColorName)
        self.borderColor = self.colorFromString(self.borderColorName)
        self.highlightedBorderColor = self.colorFromString(self.highlightedBorderColorName)
        self.selectedBorderColor = self.colorFromString(self.selectedBorderColorName)
        self.disabledBorderColor = self.colorFromString(self.disabledBorderColorName)
    }
}
