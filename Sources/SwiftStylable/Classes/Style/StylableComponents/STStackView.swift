//
//  STStackView.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 23/03/2020.
//

import UIKit

@IBDesignable open class STStackView: UIStackView, Stylable, StackViewSpacingStylable {
    
//    private var _dimension:String?
    private var _stComponentHelper: STComponentHelper!
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
//    public init() {
//        super.init(frame: CGRect.zero)
//        NotificationCenter.default.addObserver(self, selector: #selector(STStackView.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
//    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpSTComponentHelper()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpSTComponentHelper()
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @IBInspectable open var styleName:String? {
        set {
            self._stComponentHelper.styleName = newValue
        }
        get {
            return self._stComponentHelper.styleName
        }
    }
    
    @IBInspectable open var substyleName:String? {
        set {
            self._stComponentHelper.substyleName = newValue
        }
        get {
            return self._stComponentHelper.substyleName
        }
    }
    
    var stackViewSpacing: CGFloat? {
        didSet {
            if let spacing = self.stackViewSpacing, spacing != oldValue {
                self.spacing = spacing
            }
        }
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self._stComponentHelper.applyStyle(style)
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
//    public func applyDimension(_ name:String){
//        if self._dimension != name{
//            self._dimension = name
//            self.updateDimension()
//        }
//    }
    
//    public func updateDimension(){
//        if let dimentionName = self._dimension{
//            if let size = Styles.shared.dimensionNamed(dimentionName){
//                self.spacing = size
//            } else {
//                print("WARNING: Dimention \(dimentionName) does not exist. (Is the dimention of type \"number\" in the plist 😉)")
//            }
//        }
//    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    @objc internal func stylesDidUpdate(_ notification:Notification) {
//        self.updateDimension()
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
            StackViewSpacingStyler(self)
        ])
    }
    
}
