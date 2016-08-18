//
//  STImageView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable public class STImageView : UIImageView {
    @IBInspectable public var imageName:String? {
        didSet {
            if let imageName = self.imageName, helper = STHelper.sharedHelper as? SwiftStylableHelper {
                self.image = helper.imageNamed(imageName)
            } else {
                self.image = nil
            }
        }
    }
}