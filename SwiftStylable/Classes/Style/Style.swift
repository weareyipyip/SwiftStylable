//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


open class Style {
    public let name:String
    
    public let foregroundStyle:ForegroundStyle
    public let backgroundAndBorderStyle:BackgroundAndBorderStyle
    public let textStyle:TextStyle
    public let textBorderStyle:TextBorderStyle
    public let styledTextStyle:StyledTextStyle
    public let placeholderStyle:PlaceholderStyle
    public let imageStyle:ImageStyle
    public let tableViewSeparatorStyle:TableViewSeparatorStyle
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public init(name:String, parent:Style? = nil, data:[String:Any]) {
        self.name = name
        
        self.foregroundStyle = ForegroundStyle(name: name, parent: parent?.foregroundStyle, data: data)
        self.backgroundAndBorderStyle = BackgroundAndBorderStyle(name: name, parent: parent?.backgroundAndBorderStyle, data: data)
        self.textStyle = TextStyle(name: name, parent: parent?.textStyle, data: data)
        self.textBorderStyle = TextBorderStyle(name: name, parent: parent?.textBorderStyle, data: data)
        self.styledTextStyle = StyledTextStyle(name: name, parent: parent?.styledTextStyle, data: data)
        self.placeholderStyle = PlaceholderStyle(name: name, parent: parent?.placeholderStyle, data: data)
        self.imageStyle = ImageStyle(name: name, parent: parent?.imageStyle, data: data)
        self.tableViewSeparatorStyle = TableViewSeparatorStyle(name: name, parent: parent?.tableViewSeparatorStyle, data: data)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public func parseData(_ data:[String:Any]) {
        self.foregroundStyle.applyData(data)
        self.backgroundAndBorderStyle.applyData(data)
        self.textStyle.applyData(data)
        self.textBorderStyle.applyData(data)
        self.styledTextStyle.applyData(data)
        self.placeholderStyle.applyData(data)
        self.imageStyle.applyData(data)
        self.tableViewSeparatorStyle.applyData(data)
    }
}
