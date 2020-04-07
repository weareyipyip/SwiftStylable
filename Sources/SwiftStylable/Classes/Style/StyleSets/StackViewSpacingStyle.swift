//
//  StackViewSpacingStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 07/04/2020.
//

import Foundation

public class StackViewSpacingStyle: StyleSetBase {
    
    public private(set) var stackViewSpacing: CGFloat?
    
    private let _parent: StackViewSpacingStyle?
    
    private var _stackViewSpacing: CGFloat?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name: String, parent: StackViewSpacingStyle? = nil, data: [String:Any], colorCollection: ColorCollection, dimensionCollection: DimensionCollection) {
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
    
    override internal func _applyData(_ data: [String:Any]) {
        super._applyData(data)
        
        if let stackViewSpacing = data["stackViewSpacing"] as? CGFloat {
            self._stackViewSpacing = stackViewSpacing
        }
    }
    
    override internal func update() {
        super.update()
        self.stackViewSpacing = self._stackViewSpacing ?? self._parent?.stackViewSpacing
    }
}
