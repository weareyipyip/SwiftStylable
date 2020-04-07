//
//  STLayoutContraint.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 04/02/2019.
//

import UIKit

@IBDesignable open class STLayoutContraint: NSLayoutConstraint {
    
    private var _dimension:String?
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STLayoutContraint.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STLayoutContraint.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable open var dimension:String? {
        set {
            self._dimension = newValue
            self.updateDimension()
        }
        get {
            return self._dimension
        }
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public func applyDimension(_ name:String){
        if self._dimension != name{
            self._dimension = name
            self.updateDimension()
        }
    }
    
    public func updateDimension(){
        if let dimensionName = self._dimension{
            if let size = Styles.shared.dimensionNamed(dimensionName){
                self.constant = size
            } else {
                print("WARNING: Dimension \(dimensionName) does not exist. (Is the dimension of type \"number\" in the plist 😉)")
            }
        }
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @objc internal func stylesDidUpdate(_ notification:Notification) {
        self.updateDimension()
    }
}
