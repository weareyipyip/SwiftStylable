//
//  PaintCodeHelper.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


class PaintCodeHelper {
    public class func imageNamed(_ name:String)->UIImage? {
        switch(name) {
            
        case "facebookIcon":
            return StyleKit.imageOfFacebookIcon
            
        case "whatsAppIcon":
            return StyleKit.imageOfWhatsAppIcon
            
        case "callIcon":
            return StyleKit.imageOfCallIcon
            
        case "eMailIcon":
            return StyleKit.imageOfEMailIcon
            
        case "twitterIcon":
            return StyleKit.imageOfTwitterIcon
            
        case "linkedInIcon":
            return StyleKit.imageOfLinkedInIcon
            
        case "homeIcon":
            return StyleKit.imageOfHomeIcon
            
        default:
            return nil
        }
    }
}
