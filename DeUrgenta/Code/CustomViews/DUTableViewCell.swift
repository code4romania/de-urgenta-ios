//
//  DUTableViewCell.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

protocol DUTableViewCellType: UITableViewCell {
    static var cellIdentifier: String { get }
    static var nibName: String { get }
}

class DUTableViewCell: UITableViewCell, DUTableViewCellType {
    static var cellIdentifier: String { String(describing: self) }
    static var nibName: String { Self.cellIdentifier }
    override var reuseIdentifier: String? { Self.cellIdentifier }
}
