//
//  AccessibilityViewController.swift
//  SwiftStylableExample
//
//  Created by Lars Moesman on 30/01/2023.
//  Copyright © 2023 YipYip. All rights reserved.
//

import UIKit
import SwiftStylable

internal class AccessibilityViewController: UIViewController {
    
    @IBOutlet private weak var manualStyleLabel: STLabel!
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        self.manualStyleLabel.font = Styles.shared.styleNamed("bodyText")?.textStyle.dynamicFont
        self.manualStyleLabel.adjustsFontForContentSizeCategory = true
    }
    
}
