//
//  STStackView.swift
//  Pods-SwiftStylableExample
//
//  Created by Rens Wijnmalen on 23/03/2020.
//

import UIKit

@IBDesignable open class STStackView: UIStackView, Stylable, StackViewSpacingStylable {
    
    private var _stComponentHelper: STComponentHelper!
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
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
