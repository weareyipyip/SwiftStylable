//
//  PCImage.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 24/07/2017.
//  Copyright © 2017 YipYip. All rights reserved.
//

import Foundation
import SwiftStylable

@IBDesignable class PCImageView : STImageView {
    
    
    override func paintCodeImageNamed(_ name:String)->UIImage? {
        return PaintCodeHelper.imageNamed(name)
    }
}
