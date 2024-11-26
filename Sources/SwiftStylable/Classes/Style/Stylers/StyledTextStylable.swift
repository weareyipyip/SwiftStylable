//
//  StyledTextStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 19/04/2018.
//

import UIKit

protocol StyledTextStylable : AnyObject {
    var styledTextAttributes:[NSAttributedString.Key:Any]? { get set }
    var styledTextFontStyle: UIFont.TextStyle? { get set }
    var styledTextFontStyleMaximumSize: CGFloat? { get set }
    func createStyledTextDynamicFont() -> UIFont?
}

extension StyledTextStylable {
    func createStyledTextDynamicFont() -> UIFont? {
        let attributes = self.styledTextAttributes ?? [:]
        guard let styledTextFontStyle, let textFont = attributes[NSAttributedString.Key.font] as? UIFont else {
            return nil
        }
        
        if let styledTextFontStyleMaximumSize {
            return UIFontMetrics(forTextStyle: styledTextFontStyle).scaledFont(for: textFont, maximumPointSize: styledTextFontStyleMaximumSize)
        } else {
            return UIFontMetrics(forTextStyle: styledTextFontStyle).scaledFont(for: textFont)
        }
    }
}
