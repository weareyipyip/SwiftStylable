//
//  STHorizontalHairline.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 27/02/2017.
//
//

import Foundation
import UIKit


@IBDesignable class STHorizontalHairline : UIView, Stylable {
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------

    override var intrinsicContentSize:CGSize {
        get {
            return CGSize(width: 1.0, height: CGFloat(1.0 / UIScreen.main.nativeScale))
        }
    }
    
	@IBInspectable open var styleName:String? {
		didSet {
			self.updateStyles()
		}
	}
	
	@IBInspectable open var substyleName:String? {
		didSet {
			self.updateStyles()
		}
	}
	
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    func stylesDidUpdate(_ notification:Notification) {
        self.updateStyles()
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self.backgroundColor = style.backgroundColor
    }
}
