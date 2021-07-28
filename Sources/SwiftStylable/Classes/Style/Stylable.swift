//
//  Stylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation


public protocol Stylable : AnyObject {
	var styleName:String? { get set }
	var substyleName:String? { get set }
	
	func applyStyle(_ style:Style)
}

extension Stylable {
	public func updateStyles() {
        if let styleName = self.styleName {
            if let style = Styles.shared.styleNamed(styleName) {
                self.applyStyle(style)
            } else {
                print("WARNING: Style \(styleName) does not exist.")
            }
		}
        if let substyleName = self.substyleName {
            if let substyle = Styles.shared.styleNamed(substyleName) {
                self.applyStyle(substyle)
            } else {
                print("WARNING: Substyle \(substyleName) does not exist.")
            }
		}
	}
}


