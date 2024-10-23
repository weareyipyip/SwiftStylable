//
//  StyledTextStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import UIKit

public class StyledTextStyle : StyleSetBase {
    
    public private(set) var styledTextAttributes:[NSAttributedString.Key:Any]?
    public private(set) var fontTextStyleMaximumSize:CGFloat?
    
    private let _parent:StyledTextStyle?
    
    internal var _styledTextDictionary:[String:Any]?
    private var _fontTextStyle:UIFont.TextStyle?
    private var _fontTextStyleMaximumSizeDescription:Any?

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    var styledTextDictionary:[String:Any]? {
        if let ownStyledTextDictionary = self._styledTextDictionary, let parentStyledTextDictionary = self._parent?.styledTextDictionary {
            let mergedDictionary = self.mergeDictionariesRecursively(priorityDictionary: ownStyledTextDictionary, otherDictionary: parentStyledTextDictionary)
            return mergedDictionary
        } else {
            return self._styledTextDictionary ?? self._parent?.styledTextDictionary
        }
    }
    
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
    
    internal init(name:String, parent:StyledTextStyle? = nil, data:[String:Any], colorCollection:ColorCollection, dimensionCollection: DimensionCollection) {
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
        
        if let styledTextDictionary = data["styledTextAttributes"] as? [String:Any] {
            self._styledTextDictionary = styledTextDictionary
            if let font = styledTextDictionary["font"] as? [String:Any] {
                self._fontTextStyleMaximumSizeDescription = font["textStyleMaximumSize"]
                if
                    let rawTextStyleValue = font["textStyle"] as? String,
                    let textStyle = UIFont.TextStyle(rawStyleValue: rawTextStyleValue)
                {
                    self._fontTextStyle = textStyle
                }
            }
        }
    }
    
    override internal func update() {
        super.update()
        
        self.styledTextAttributes = self.stringAttributesFromDictionary(self.styledTextDictionary)
        
        if let fontTextStyleMaximumSize = self.dimensionFromValue(self.fontTextStyleMaximumSizeValue) {
            self.fontTextStyleMaximumSize = fontTextStyleMaximumSize
        }

    }
	
	private func mergeDictionariesRecursively(priorityDictionary:[String:Any], otherDictionary:[String:Any])->[String:Any] {
		return priorityDictionary.merging(otherDictionary, uniquingKeysWith: { (priorityValue, otherValue) -> Any in
			var result:Any
			if let priorityValueDictionary = priorityValue as? [String:Any], let otherValueDictionary = otherValue as? [String:Any] {
				result = self.mergeDictionariesRecursively(priorityDictionary: priorityValueDictionary, otherDictionary: otherValueDictionary)
			} else {
				result = priorityValue
			}
			return result
		})
	}
}
