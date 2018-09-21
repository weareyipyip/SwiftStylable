//
//  TableViewSeparatorStyle.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 20/09/2018.
//

import Foundation

public class TableViewSeparatorStyle : StyleSetBase {
    
    public private(set) var tableViewSeparatorStyle:UITableViewCell.SeparatorStyle?
    public private(set) var tableViewSeparatorColor:UIColor?

    private let _parent:TableViewSeparatorStyle?

    private var _tableViewSeparatorStyle:UITableViewCell.SeparatorStyle?
    private var _tableViewSeparatorColorString:String?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    internal init(name:String, parent:TableViewSeparatorStyle? = nil, data:[String:Any]) {
        self._parent = parent
        super.init(name: name, parent: parent)
        self.applyData(data)
    }

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    override internal func _applyData(_ data:[String:Any]) {
        super._applyData(data)
        
        if let tableViewSeparatorStyleString = data["tableViewSeparatorStyle"] as? String {
            switch tableViewSeparatorStyleString {
            case "none":
                self._tableViewSeparatorStyle = UITableViewCell.SeparatorStyle.none
                
            case "singleLine":
                self._tableViewSeparatorStyle = UITableViewCell.SeparatorStyle.singleLine
                
            case "singleLineEtched":
                self._tableViewSeparatorStyle = UITableViewCell.SeparatorStyle.singleLineEtched
                
            default:
                break
            }
        }
        if let tableViewSeparatorColorString = data["tableViewSeparatorColor"] as? String {
            self._tableViewSeparatorColorString = tableViewSeparatorColorString
        }
    }
    
    override internal func update() {
        super.update()
        self.tableViewSeparatorStyle = self._tableViewSeparatorStyle ?? self._parent?.tableViewSeparatorStyle
        self.tableViewSeparatorColor = self.colorFromString(self._tableViewSeparatorColorString) ?? self._parent?.tableViewSeparatorColor
    }
}
