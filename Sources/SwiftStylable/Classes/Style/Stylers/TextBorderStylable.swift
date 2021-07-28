//
//  TextBorderStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 19/04/2018.
//

import UIKit

protocol TextBorderStylable : AnyObject {
    var layer:CALayer { get }
    var borderStyle: UITextField.BorderStyle { get set }
}
