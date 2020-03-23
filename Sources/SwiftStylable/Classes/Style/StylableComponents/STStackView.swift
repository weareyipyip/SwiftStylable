//
//  STStackView.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 23/03/2020.
//

import UIKit

@IBDesignable open class STStackView: UIStackView {

    private var _dimension:String?
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public init() {
        super.init(frame: CGRect.zero) 
        NotificationCenter.default.addObserver(self, selector: #selector(STStackView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(STStackView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(STStackView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STStackView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
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
        if let dimentionName = self._dimension{
            if let size = Styles.shared.dimensionNamed(dimentionName){
                self.spacing = size
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
        self.updateDimension()
    }
    
}
