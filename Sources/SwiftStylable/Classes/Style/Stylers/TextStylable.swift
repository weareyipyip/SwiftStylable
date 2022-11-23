//
//  TextStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import UIKit

protocol TextStylable : AnyObject {

    /*
    The type optionality of the font property varies across components. This makes a generic implementation impossible. For
    this reason a textFont property is used, the implementation is left to specific components.
    */
	var textFont: UIFont? { get set }
    var textFontStyle: UIFont.TextStyle? { get set }
	var fullUppercaseText: Bool { get set }
}
