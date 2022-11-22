//
//  UIFontTextStyle+StyleValue.swift
//  Pods-SwiftStylableExample
//
//  Created by Lars Moesman on 21/11/2022.
//

import UIKit

internal extension UIFont.TextStyle {
    init?(rawStyleValue: String?) {
        guard let value = rawStyleValue, !value.isEmpty else { return nil }
        let prefix = UIFont.TextStyle.body.rawValue.dropLast(4)
        self.init(rawValue: "\(prefix)\(value.capitalized)")
    }
}
