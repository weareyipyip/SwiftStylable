//
//  STHorizontalHairline.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 27/02/2017.
//
//

import Foundation
import UIKit


@IBDesignable open class STSwitch : UISwitch, Stylable {
    
    
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
    
    @IBInspectable open var styleName:String? {
        didSet {
            if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
                self.applyStyle(style)
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    func stylesDidUpdate(_ notification:Notification) {
        if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
            self.applyStyle(style)
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self.tintColor = style.backgroundColor
        self.onTintColor = style.selectedBackgroundColor
        self.thumbTintColor = style.foregroundColor
    }
}