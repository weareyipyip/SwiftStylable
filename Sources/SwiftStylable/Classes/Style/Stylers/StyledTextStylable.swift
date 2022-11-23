//
//  StyledTextStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 19/04/2018.
//

import Foundation

protocol StyledTextStylable : AnyObject {
    var styledTextAttributes:[NSAttributedString.Key:Any]? { get set }
    var styledTextFontStyle: UIFont.TextStyle? { get set }
}
