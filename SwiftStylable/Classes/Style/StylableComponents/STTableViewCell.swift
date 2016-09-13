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
	
	private var _backgroundColor:UIColor!
	private var _borderColor:UIColor!
	private var _highlightedBackgroundColor:UIColor!
	private var _highlightedBorderColor:UIColor!
	private var _selectedBackgroundColor:UIColor!
	private var _selectedBorderColor:UIColor!
	
	
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(STTableViewCell.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
        
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------

    @IBInspectable public var styleName:String? {
        didSet {
            if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
                self.applyStyle(style)
            }
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
    
    override public func setSelected(selected: Bool, animated: Bool) {
        self._selected = selected
		if self.styleName != nil {
            self.updateColors()
        } else {
            super.setSelected(selected, animated: animated)
        }
    }
    
    override public func setHighlighted(highlighted: Bool, animated: Bool) {
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
    
    public func applyStyle(style:Style) {
		self.layer.borderWidth = style.borderWidth
		self.layer.cornerRadius = style.cornerRadius
		
		self._backgroundColor = style.backgroundColor
		self._borderColor = style.borderColor
		self._highlightedBackgroundColor = style.highlightedBackgroundColor
		self._highlightedBorderColor = style.highlightedBorderColor
		self._selectedBackgroundColor = style.selectedBackgroundColor
		self._selectedBorderColor = style.selectedBorderColor
		
		self.updateColors()
    }
	
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    func stylesDidUpdate(notification:NSNotification) {
        // Set styleName to itself, to force re-acquiring the style from Styles class
        let styleName = self.styleName
        self.styleName = styleName
    }
    

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func updateColors() {
        if self._highlighted {
            self.backgroundColor = self._highlightedBackgroundColor
            self.layer.borderColor = self._highlightedBorderColor.CGColor
        } else if self._selected {
            self.backgroundColor = self._selectedBackgroundColor
            self.layer.borderColor = self._selectedBorderColor.CGColor
        } else {
            self.backgroundColor = self._backgroundColor
            self.layer.borderColor = self._borderColor.CGColor
        }
    }
}
