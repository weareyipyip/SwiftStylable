//
//  PlaceholderTextStylable.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import Foundation

protocol PlaceholderStylable : class {
    var fullUppercasePlaceholder:Bool { get set }
    var styledPlaceholderAttributes:[NSAttributedStringKey:Any]? { get set }
}
