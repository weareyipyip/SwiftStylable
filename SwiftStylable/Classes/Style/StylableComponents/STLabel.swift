//
//  STLabel.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class STLabel : UILabel, Stylable {

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(STLabel.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(STLabel.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
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
    // MARK: - Public properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public func applyStyle(style:Style) {
        self.font = style.font
        self.textColor = style.foregroundColor
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
	func stylesDidUpdate(notification:NSNotification) {
		if let styleName = self.styleName, style = Styles.sharedStyles.styleNamed(styleName) {
			self.applyStyle(style)
		}
	}
}
