//
//  InfoConfigurationViewController.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 02.04.2021.
//

import UIKit
import SnapKit

class InfoConfigurationViewController: DUViewController {
    
    let viewModel = InfoConfigurationViewModel()
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    
    @IBOutlet weak var configureAddressesItemView: InfoConfigurationItemView!
    @IBOutlet weak var createGroupItemView: InfoConfigurationItemView!
    @IBOutlet weak var emergencyBagItemView: InfoConfigurationItemView!
    @IBOutlet weak var firstAidTutorialItemView: InfoConfigurationItemView!
    
    var hasConfiguredAddresses = false {
        didSet {
            self.configureItems()
        }
    }
    
    enum HeaderType {
        case welcome(name: String)
        case `default`
    }
    
    private enum ConfigurationItem: String {
        case addresses = "ro.code4.DeUrgenta.InfoConfigurationViewController.addresses"
        case group = "ro.code4.DeUrgenta.InfoConfigurationViewController.group"
        case emergencyBag = "ro.code4.DeUrgenta.InfoConfigurationViewController.emergencyBag"
        case firstAidTutorial = "ro.code4.DeUrgenta.InfoConfigurationViewController.firstAidTutorial"
    }
    
    var headerType: HeaderType = .default {
        didSet {
            self.updateHeader()
        }
    }

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
        switch self.headerType {
        case .default:
            self.loadDefaultHeader()
        case .welcome(name: let name):
            self.loadWelcomeHeader(withTitle: "Felicitări, \(name)!")
        }
    }
    
    private func configureItems() {
        self.configureAddressesItemView.enabled = true
        self.createGroupItemView.enabled = self.hasConfiguredAddresses
        self.emergencyBagItemView.enabled = self.hasConfiguredAddresses
        self.firstAidTutorialItemView.enabled = self.hasConfiguredAddresses
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

}

extension InfoConfigurationViewController: InfoConfigurationItemViewDelegate {
    
    func infoConfigurationItemViewTapped(_ infoConfigurationItemView: InfoConfigurationItemView) {
        guard let identifier = infoConfigurationItemView.identifier,
              let configurationItem = ConfigurationItem(rawValue: identifier)
        else { return }
        
        switch configurationItem {
        case .addresses:
            LogInfo("Configure addresses")
        case .group:
            LogInfo("Configure group")
        case .emergencyBag:
            LogInfo("Configure emergency bag")
        case .firstAidTutorial:
            LogInfo("First aid tutorial")
        }
    }
}
