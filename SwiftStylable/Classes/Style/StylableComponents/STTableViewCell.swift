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
        
        NotificationCenter.default.addObserver(self, selector: #selector(STTableViewCell.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
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
		if let borderWidth = style.borderWidth {
			self.layer.borderWidth = borderWidth
		}
		if let cornerRadius = style.cornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
		if let backgroundColor = style.backgroundColor {
			self._backgroundColor = backgroundColor
		}
		if let borderColor = style.borderColor {
			self._borderColor = borderColor
		}
		if let highlightedBackgroundColor = style.highlightedBackgroundColor {
			self._highlightedBackgroundColor = highlightedBackgroundColor
		}
		if let highlightedBorderColor = style.highlightedBorderColor {
			self._highlightedBorderColor = highlightedBorderColor
		}
		if let selectedBackgroundColor = style.selectedBackgroundColor {
			self._selectedBackgroundColor = selectedBackgroundColor
		}
		if let selectedBorderColor = style.selectedBorderColor {
			self._selectedBorderColor = selectedBorderColor
		}
		
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
