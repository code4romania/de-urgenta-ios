//
//  InfoConfigurationViewController.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 02.04.2021.
//

import UIKit
import SnapKit

class InfoConfigurationViewController: DUViewController {
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    
    @IBOutlet weak var configureAddressesItemView: InfoConfigurationItemView!
    @IBOutlet weak var createGroupItemView: InfoConfigurationItemView!
    @IBOutlet weak var emergencyBagItemView: InfoConfigurationItemView!
    @IBOutlet weak var firstAidTutorialItemView: InfoConfigurationItemView!
    
    enum HeaderType {
        case welcome(name: String)
        case `default`
    }
    
    enum ConfigurationItem: String {
        case addresses = "ro.code4.DeUrgenta.InfoConfigurationViewController.addresses"
        case group = "ro.code4.DeUrgenta.InfoConfigurationViewController.group"
        case emergencyBag = "ro.code4.DeUrgenta.InfoConfigurationViewController.emergencyBag"
        case firstAidTutorial = "ro.code4.DeUrgenta.InfoConfigurationViewController.firstAidTutorial"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
