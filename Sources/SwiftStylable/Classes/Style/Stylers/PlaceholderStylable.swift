//
//  PlaceholderTextStylable.swift
//  Pods-SwiftStylableExample
//
//  Created by Bob De Kort-Goossens on 19/07/2018.
//

import UIKit

protocol PlaceholderStylable : AnyObject {
    var fullUppercasePlaceholder:Bool { get set }
    var styledPlaceholderAttributes:[NSAttributedString.Key:Any]? { get set }
    var styledPlaceholderFontStyle: UIFont.TextStyle? { get set }
    var styledPlaceholderFontStyleMaximumSize: CGFloat? { get set }
    func createStyledPlaceholderDynamicFont() -> UIFont?
}

extension PlaceholderStylable {
    func createStyledPlaceholderDynamicFont() -> UIFont? {
        let attributes = self.styledPlaceholderAttributes ?? [:]
        guard let styledPlaceholderFontStyle, let textFont = attributes[NSAttributedString.Key.font] as? UIFont else {
            return nil
        }
        if let styledPlaceholderFontStyleMaximumSize {
            return UIFontMetrics(forTextStyle: styledPlaceholderFontStyle).scaledFont(for: textFont, maximumPointSize: styledPlaceholderFontStyleMaximumSize)
        } else {
            return UIFontMetrics(forTextStyle: styledPlaceholderFontStyle).scaledFont(for: textFont)
        }
    }
}
