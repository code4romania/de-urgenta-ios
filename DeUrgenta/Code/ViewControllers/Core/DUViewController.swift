//
//  DUViewController.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 01.04.2021.
//

import UIKit

/// Base class for screen view controllers
class DUViewController: UIViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsManager.shared.log(.screenVisited(name: String(describing: self)))
    }
}
