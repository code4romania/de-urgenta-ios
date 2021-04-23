//
//  AppEntryViewController.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.04.2021.
//

import UIKit
import SnapKit

class AppEntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .mainAccent
        let spinner = DUSpinner()
        spinner.tintColor = .white
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        spinner.isAnimating = true
    }
    
}
