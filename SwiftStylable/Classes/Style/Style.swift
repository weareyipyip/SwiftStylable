//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


public class Style {
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
    
    internal init(name:String, parent:Style? = nil, data:[String:Any], colorCollection:ColorCollection) {
        self.name = name
        
        self.foregroundStyle = ForegroundStyle(name: name, parent: parent?.foregroundStyle, data: data, colorCollection: colorCollection)
        self.backgroundAndBorderStyle = BackgroundAndBorderStyle(name: name, parent: parent?.backgroundAndBorderStyle, data: data, colorCollection: colorCollection)
        self.textStyle = TextStyle(name: name, parent: parent?.textStyle, data: data, colorCollection: colorCollection)
        self.textBorderStyle = TextBorderStyle(name: name, parent: parent?.textBorderStyle, data: data, colorCollection: colorCollection)
        self.styledTextStyle = StyledTextStyle(name: name, parent: parent?.styledTextStyle, data: data, colorCollection: colorCollection)
        self.placeholderStyle = PlaceholderStyle(name: name, parent: parent?.placeholderStyle, data: data, colorCollection: colorCollection)
        self.imageStyle = ImageStyle(name: name, parent: parent?.imageStyle, data: data, colorCollection: colorCollection)
        self.tableViewSeparatorStyle = TableViewSeparatorStyle(name: name, parent: parent?.tableViewSeparatorStyle, data: data, colorCollection: colorCollection)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal func parseData(_ data:[String:Any]) {
        self.foregroundStyle.applyData(data)
        self.backgroundAndBorderStyle.applyData(data)
        self.textStyle.applyData(data)
        self.textBorderStyle.applyData(data)
        self.styledTextStyle.applyData(data)
        self.placeholderStyle.applyData(data)
        self.imageStyle.applyData(data)
        self.tableViewSeparatorStyle.applyData(data)
    }
    
    internal func update() {
        self.foregroundStyle.update()
        self.backgroundAndBorderStyle.update()
        self.textStyle.update()
        self.textBorderStyle.update()
        self.styledTextStyle.update()
        self.placeholderStyle.update()
        self.imageStyle.update()
        self.tableViewSeparatorStyle.update()
    }
}
