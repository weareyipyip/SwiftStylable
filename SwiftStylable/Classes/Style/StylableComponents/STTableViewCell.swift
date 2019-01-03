//
//  STTableViewCell.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STTableViewCell : UITableViewCell, Stylable, BackgroundAndBorderStylable
{
    private var _stComponentHelper: STComponentHelper!
    
    private var _selected = false
    private var _highlighted = false
    
    private var _normalBackgroundColor:UIColor?
    private var _borderColor:UIColor?
    private var _highlightedBackgroundColor:UIColor?
    private var _highlightedBorderColor:UIColor?
    private var _selectedBackgroundColor:UIColor?
    private var _selectedBorderColor:UIColor?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpSTComponentHelper()
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable open var styleName:String? {
        set {
            self._stComponentHelper.styleName = newValue
        }
        get {
            return self._stComponentHelper.styleName
        }
    }
    
    @IBInspectable open var substyleName:String? {
        set {
            self._stComponentHelper.substyleName = newValue
        }
        get {
            return self._stComponentHelper.substyleName
        }
    }
    
    var normalBackgroundColor: UIColor? {
        get {
            return self._normalBackgroundColor
        }
        set {
            self._normalBackgroundColor = newValue
        }
    }
    
    var highlightedBackgroundColor: UIColor? {
        get {
            return self._highlightedBackgroundColor
        }
        set {
            self._highlightedBackgroundColor = newValue
        }
    }
    var selectedBackgroundColor: UIColor? {
        get {
            return self._selectedBackgroundColor
        }
        set {
            self._selectedBackgroundColor = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            var color:UIColor?
            if let cgColor = self.layer.borderColor {
                color = UIColor(cgColor: cgColor)
            }
            return color
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    var highlightedBorderColor: UIColor? {
        get {
            return self._highlightedBorderColor
        }
        set {
            self._highlightedBorderColor = newValue
        }
    }
    
    var selectedBorderColor: UIColor? {
        get {
            return self._selectedBorderColor
        }
        set {
            self._selectedBorderColor = newValue
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    // -----------------------------------------------------------
    // -- TableViewCell overrides
    // -----------------------------------------------------------
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        self._selected = selected
        if self.styleName != nil {
            self.updateColors()
        } else {
            super.setSelected(selected, animated: animated)
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self._highlighted = highlighted
        if self.styleName != nil {
            self.updateColors()
        } else {
            super.setHighlighted(highlighted, animated: animated)
        }
    }
    
    // -----------------------------------------------------------
    // -- Stylable implementation
    // -----------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self._stComponentHelper.applyStyle(style)
        self.updateColors()
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
            BackgroundAndBorderStyler(self, canBeHighlighted: true, canBeSelected: true)
            ])
    }
    
    private func updateColors() {
        if self._highlighted {
            self.backgroundColor = self._highlightedBackgroundColor ?? self._normalBackgroundColor
            self.layer.borderColor = (self._highlightedBorderColor?.cgColor ?? self._borderColor?.cgColor) ?? UIColor.clear.cgColor
        } else if self._selected {
            self.backgroundColor = self._selectedBackgroundColor ?? self._normalBackgroundColor
            self.layer.borderColor = (self._selectedBorderColor?.cgColor ?? self._borderColor?.cgColor) ?? UIColor.clear.cgColor
        } else {
            self.backgroundColor = self._normalBackgroundColor
            self.layer.borderColor = (self._borderColor ?? UIColor.clear).cgColor
        }
    }
}
