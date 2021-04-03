//
//  InfoConfigurationViewController.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 02.04.2021.
//

import UIKit
import SnapKit

class InfoConfigurationViewController: DUViewController {
    
    let model = InfoConfigurationViewModel()
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    
    @IBOutlet weak var configureAddressesItemView: InfoConfigurationItemView!
    @IBOutlet weak var createGroupItemView: InfoConfigurationItemView!
    @IBOutlet weak var emergencyBagItemView: InfoConfigurationItemView!
    @IBOutlet weak var firstAidTutorialItemView: InfoConfigurationItemView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateHeader()
        self.configureItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func updateHeader() {
        switch self.model.headerType {
        case .default:
            self.loadDefaultHeader()
        case .welcome(name: let name):
            self.loadWelcomeHeader(withTitle: "Felicitări, \(name)!")
        }
    }
    
    private func configureItems() {
        self.configureAddressesItemView.enabled = true
        self.createGroupItemView.enabled = self.model.hasConfiguredAddresses
        self.emergencyBagItemView.enabled = self.model.hasConfiguredAddresses
        self.firstAidTutorialItemView.enabled = self.model.hasConfiguredAddresses
        
        self.setupConfigureAddressesItem()
        self.setupCreateGroupItem()
        self.setupEmergencyBagItem()
        self.setupFirstAidTutorialItem()
    }
    
    private func loadWelcomeHeader(withTitle title: String) {
        let welcomeHeaderView = InfoConfigurationWelcomHeaderView.loadFromNib()
        welcomeHeaderView.headerLabel.text = title
        self.replaceHeader(with: welcomeHeaderView)
    }
    
    private func loadDefaultHeader() {
        let defaultHeaderView = InfoConfigurationHeaderView.loadFromNib()
        self.replaceHeader(with: defaultHeaderView)
    }
    
    private func replaceHeader(with view: UIView?) {
        for subview in self.headerContainerView.subviews {
            subview.removeFromSuperview()
        }
        
        guard let view = view else { return }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.headerContainerView)
        }
    }
    
    private func setupConfigureAddressesItem() {
        self.configureAddressesItemView.onTap { [weak self] in
            LogInfo("Configure addresses")
        }
    }
    
    private func setupCreateGroupItem() {
        self.createGroupItemView.onTap { [weak self] in
            LogInfo("Create group")
        }
    }
    
    private func setupEmergencyBagItem() {
        self.emergencyBagItemView.onTap { [weak self] in
            LogInfo("Configure emergency bag")
        }
    }
    
    private func setupFirstAidTutorialItem() {
        self.firstAidTutorialItemView.onTap { [weak self] in
            LogInfo("First aid tutorial")
        }
    }

}
