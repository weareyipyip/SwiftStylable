//
//  UIFontTextStyle+StyleValue.swift
//  Pods-SwiftStylableExample
//
//  Created by Lars Moesman on 21/11/2022.
//

import UIKit

internal extension UIFont.TextStyle {
    
    init?(rawStyleValue: String?) {
        switch rawStyleValue {
        case "largeTitle":
            self = .largeTitle
        case "title1":
            self = .title1
        case "title2":
            self = .title2
        case "title3":
            self = .title3
        case "headline":
            self = .headline
        case "subheadline":
            self = .subheadline
        case "body":
            self = .body
        case "callout":
            self = .callout
        case "footnote":
            self = .footnote
        case "caption1":
            self = .caption1
        case "caption2":
            self = .caption2
        case "none":
            self.init(rawValue: "None")
        default:
            print("WARNING: TextStyle \(rawStyleValue ?? "") does not exist.")
            return nil
        }
    }
}
