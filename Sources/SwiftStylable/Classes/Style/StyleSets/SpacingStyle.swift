//
//  SpacingStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 07/04/2020.
//

import UIKit

public class SpacingStyle: StyleSetBase {
    
    public private(set) var spacing: CGFloat?
    public private(set) var imagePadding: CGFloat?
    
    private let _parent: SpacingStyle?
    
    private var _spacingValue: Any?
    private var _imageSpacingValue: Any?
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name: String, parent: SpacingStyle? = nil, data: [String: Any], colorCollection: ColorCollection, dimensionCollection: DimensionCollection) {
        self._parent = parent
        super.init(name: name, parent: parent, colorCollection: colorCollection, dimensionCollection: dimensionCollection)
        self.applyData(data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    
    internal var spacingDescription: Any? {
        return self._spacingValue ?? self._parent?.spacingDescription
    }
    
    internal var imagePaddingDescription: Any? {
        return self._imageSpacingValue ?? self._parent?.imagePaddingDescription
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data: [String: Any]) {
        super._applyData(data)
        self._spacingValue = data["spacing"]
        self._imageSpacingValue = data["imagePadding"]
    }
    
    override internal func update() {
        super.update()
        if let spacing = self.dimensionFromValue(self.spacingDescription) {
            self.spacing = spacing
        }
        if let imagePadding = self.dimensionFromValue(self.imagePaddingDescription) {
            self.imagePadding = imagePadding
        }
    }
}
