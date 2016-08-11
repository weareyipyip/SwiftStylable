//
//  Stylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation


public protocol Stylable {
	var styleName:String? { get set }
	
	func applyStyle(style:Style)
}
