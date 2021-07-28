//
//  SeparatorStylable.swift
//  Pods-SwiftStylableExample
//
//  Created by Marcel Bloemendaal on 19/04/2018.
//

import UIKit

protocol TableViewSeparatorStylable : AnyObject {
    var separatorColor: UIColor? { get set }
    var separatorStyle: UITableViewCell.SeparatorStyle { get set }
}
