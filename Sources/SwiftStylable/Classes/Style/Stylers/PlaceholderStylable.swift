//
//  PlaceholderTextStylable.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import Foundation

protocol PlaceholderStylable : AnyObject {
    var fullUppercasePlaceholder:Bool { get set }
    var styledPlaceholderAttributes:[NSAttributedString.Key:Any]? { get set }
}
