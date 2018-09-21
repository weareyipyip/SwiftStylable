//
//  ButtonStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class BackgroundAndBorderStyle : StyleSetBase {
    
    public private(set) var borderWidth:CGFloat?
    public private(set) var clipsToBounds:Bool?
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
    
    private var _borderWidth:CGFloat?
    private var _clipsToBounds: Bool?
    private var _cornerRadius:CGFloat?
    
    // Background color names
    private var _backgroundColorString: String?
    private var _highlightedBackgroundColorString: String?
    private var _selectedBackgroundColorString: String?
    private var _disabledBackgroundColorString: String?
    
    // Border color names
    private var _borderColorString: String?
    private var _highlightedBorderColorString: String?
    private var _selectedBorderColorString: String?
    private var _disabledBorderColorString: String?
    
    // Caches
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required internal init(name:String, parent:BackgroundAndBorderStyle? = nil, data:[String:Any]) {
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
        
        // Background colors
        if let backgroundColorString = data["backgroundColor"] as? String {
            self._backgroundColorString = backgroundColorString
        }
        if let highlightedBackgroundColorString = data["highlightedBackgroundColor"] as? String {
            self._highlightedBackgroundColorString = highlightedBackgroundColorString
        }
        if let selectedBackgroundColorString = data["selectedBackgroundColor"] as? String {
            self._selectedBackgroundColorString = selectedBackgroundColorString
        }
        if let disabledBackgroundColorString = data["disabledBackgroundColor"] as? String {
            self._disabledBackgroundColorString = disabledBackgroundColorString
        }
        
        // Border colors
        if let borderColorString = data["borderColor"] as? String {
            self._borderColorString = borderColorString
        }
        if let highlightedBorderColorString = data["highlightedBorderColor"] as? String {
            self._highlightedBorderColorString = highlightedBorderColorString
        }
        if let selectedBorderColorString = data["selectedBorderColor"] as? String {
            self._selectedBorderColorString = selectedBorderColorString
        }
        if let disabledBorderColorString = data["disabledBorderColor"] as? String {
            self._disabledBorderColorString = disabledBorderColorString
        }
        
        // Other
        if let cornerRadius = data["cornerRadius"] as? CGFloat {
            self._cornerRadius = cornerRadius
        }
        if let clipsToBounds = data["clipsToBounds"] as? Bool {
            self._clipsToBounds = clipsToBounds
        }
        if let borderWidth = data["borderWidth"] as? CGFloat {
            self._borderWidth = borderWidth
        }
        
        NotificationCenter.default.post(name: StyleSetBase.didChangeNotification, object: self)
    }
    
    override internal func update() {
        super.update()
        
        self.borderWidth = self._borderWidth ?? self._parent?.borderWidth
        self.clipsToBounds = self._clipsToBounds ?? self._parent?.clipsToBounds
        self.cornerRadius = self._cornerRadius ?? self._parent?.cornerRadius
        
        self.backgroundColor = self.colorFromString(self._backgroundColorString) ?? self._parent?.backgroundColor
        self.highlightedBackgroundColor = self.colorFromString(self._highlightedBackgroundColorString) ?? self._parent?.highlightedBackgroundColor
        self.selectedBackgroundColor = self.colorFromString(self._selectedBackgroundColorString) ?? self._parent?.selectedBackgroundColor
        self.disabledBackgroundColor = self.colorFromString(self._disabledBackgroundColorString) ?? self._parent?.disabledBackgroundColor
        self.borderColor = self.colorFromString(self._borderColorString) ?? self._parent?.borderColor
        self.highlightedBorderColor = self.colorFromString(self._highlightedBorderColorString) ?? self._parent?.highlightedBorderColor
        self.selectedBorderColor = self.colorFromString(self._selectedBorderColorString) ?? self._parent?.selectedBorderColor
        self.disabledBorderColor = self.colorFromString(self._disabledBorderColorString) ?? self._parent?.disabledBorderColor
    }
}
