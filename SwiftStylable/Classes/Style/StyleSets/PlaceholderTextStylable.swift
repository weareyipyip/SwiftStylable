//
//  PlaceholderTextStylable.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import Foundation

protocol PlaceholderTextStylable : class {
    var attributedPlaceholderString: NSAttributedString? { get set }
    var placeholder: String? { get }
}
