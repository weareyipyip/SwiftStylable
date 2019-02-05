//
//  STLayoutContraint.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 04/02/2019.
//

import UIKit

@IBDesignable open class STLayoutContraint: NSLayoutConstraint {
    
    private var _dimenstion:String?
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STActivityIndicator.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STActivityIndicator.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable open var dimenstion:String? {
        set {
            self._dimenstion = newValue
            self.updateDimention()
        }
        get {
            return self._dimenstion
        }
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public func applyDimention(_ name:String){
        if self._dimenstion != name{
            self._dimenstion = name
            self.updateDimention()
        }
    }
    
    public func updateDimention(){
        if let dimentionName = self._dimenstion{
            if let size = Styles.shared.dimentionNamed(dimentionName){
                self.constant = size
            } else {
                print("WARNING: Dimention \(dimentionName) does not exist. (Is the dimention of type \"number\" in the plist 😉)")
            }
        }
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @objc internal func stylesDidUpdate(_ notification:Notification) {
        self.updateDimention()
    }
}
