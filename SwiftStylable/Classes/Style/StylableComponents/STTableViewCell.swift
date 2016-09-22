//
//  STTableViewCell.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STTableViewCell : UITableViewCell, Stylable
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(STTableViewCell.stylesDidUpdate(_:)), name: NSNotification.Name(rawValue: STYLES_DID_UPDATE), object: nil)
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------

    @IBInspectable open var styleName:String? {
        didSet {
            if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
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
    
	func stylesDidUpdate(_ notification:Notification) {
		if let styleName = self.styleName, let style = Styles.sharedStyles.styleNamed(styleName) {
			self.applyStyle(style)
		}
	}
	

    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    fileprivate func updateColors() {
        if self._highlighted {
            self.backgroundColor = self._highlightedBackgroundColor
            self.layer.borderColor = self._highlightedBorderColor.cgColor
        } else if self._selected {
            self.backgroundColor = self._selectedBackgroundColor
            self.layer.borderColor = self._selectedBorderColor.cgColor
        } else {
            self.backgroundColor = self._backgroundColor
            self.layer.borderColor = self._borderColor.cgColor
        }
    }
}
