//
//  StyledTextStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class StyledTextStyle : StyleSetBase {
    
    public private(set) var styledTextAttributes:[NSAttributedString.Key:Any]?
    
	internal var styledTextDictionary:[String:Any]?
	
    private let _parent:StyledTextStyle?
    
    private var _fontTextStyle:UIFont.TextStyle?

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    var fontTextStyle:UIFont.TextStyle? {
        get {
            return self._fontTextStyle ?? self._parent?.fontTextStyle
        }
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
            self.styledTextDictionary = styledTextDictionary
        }
    }
    
    override internal func update() {
        super.update()
		
		if let ownStyledTextDictionary = self.styledTextDictionary, let parentStyledTextDictionary = self._parent?.styledTextDictionary {
			let mergedDictionary = self.mergeDictionariesRecursively(priorityDictionary: ownStyledTextDictionary, otherDictionary: parentStyledTextDictionary)
			self.styledTextAttributes = self.stringAttributesFromDictionary(mergedDictionary)
		} else {
			self.styledTextAttributes = self.stringAttributesFromDictionary(self.styledTextDictionary ?? self._parent?.styledTextDictionary)
		}
        
        if
            let font = self.styledTextDictionary?["font"] as? [String:Any],
            let rawTextStyleValue = font["textStyle"] as? String,
            let textStyle = UIFont.TextStyle(rawStyleValue: rawTextStyleValue)
        {
            self._fontTextStyle = textStyle
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
