//
//  STTableViewCell.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable public class STTableViewCell : UITableViewCell, Stylable
{
    private var _selected = false
    private var _highlighted = false
    private var _style:Style?
    
    @IBInspectable public var styleName:String? {
        didSet {
            if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                self._style = style
                self.applyStyle(style)
            } else {
                self._style = nil
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    // -----------------------------------------------------------
    // -- TableViewCell overrides
    // -----------------------------------------------------------
    
    override public func setSelected(selected: Bool, animated: Bool) {
        self._selected = selected
        if let style = self._style {
            self.updateColors(style)
        } else {
            super.setSelected(selected, animated: animated)
        }
    }
    
    override public func setHighlighted(highlighted: Bool, animated: Bool) {
        self._highlighted = highlighted
        if let style = self._style {
            self.updateColors(style)
        } else {
            super.setHighlighted(highlighted, animated: animated)
        }
    }
    
    // -----------------------------------------------------------
    // -- Stylable implementation
    // -----------------------------------------------------------
    
    public func applyStyle(style:Style) {
        self.backgroundColor = style.backgroundColor
        self.layer.borderWidth = style.borderWidth
        self.layer.borderColor = style.borderColor.CGColor
        self.layer.cornerRadius = style.cornerRadius
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func updateColors(style:Style) {
        if self._highlighted {
            self.backgroundColor = style.highlightedBackgroundColor
            self.layer.borderColor = style.highlightedBorderColor.CGColor
        } else if self._selected {
            self.backgroundColor = style.selectedBackgroundColor
            self.layer.borderColor = style.selectedBorderColor.CGColor
        } else {
            self.backgroundColor = style.backgroundColor
            self.layer.borderColor = style.borderColor.CGColor
        }
    }
}
