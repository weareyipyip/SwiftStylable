//
//  ImageProvider.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

public protocol SwiftStylableHelper {
    func imageNamed(name:String)->UIImage?
    func anyProjectClass()->AnyClass
}