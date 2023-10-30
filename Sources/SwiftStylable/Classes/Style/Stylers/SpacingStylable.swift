//
//  ImageStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import UIKit

protocol SpacingStylable : AnyObject {
    var spacingValue: CGFloat? { get set }
    var imagePadding: CGFloat? { get set }
}

extension SpacingStylable {
    var spacingValue: CGFloat? {
        get {
            return nil
        }
        set {
            
        }
    }
    var imagePadding: CGFloat? {
        get {
            return nil
        }
        set {
            
        }
    }
}

