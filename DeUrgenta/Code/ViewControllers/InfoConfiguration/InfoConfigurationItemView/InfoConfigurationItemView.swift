//
//  InfoConfigurationItemView.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 02.04.2021.
//

import UIKit

protocol InfoConfigurationViewDelegate: class {
    func infoConfigurationViewTapped(_ infoConfigurationView: InfoConfigurationItemView)
}

@IBDesignable
class InfoConfigurationItemView: DUNibView {
    
    @IBInspectable
    var iconImage: UIImage? = nil
    
    @IBInspectable
    var title: String? = nil
    
    @IBOutlet
    weak var iconImageView: UIImageView!
    
    @IBOutlet
    weak var titleLabel: UILabel!
    
    var identifier: String? = nil
    
    var enabled: Bool = true {
        didSet {
            self.setEnabled(self.enabled)
        }
    }
    
    weak var delegate: InfoConfigurationViewDelegate? = nil
    
    private let disabledStateAlpha: CGFloat = 0.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.registerTap()
    }
    
    private func registerTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func viewWasTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.infoConfigurationViewTapped(self)
    }
    
    private func setEnabled(_ enabled: Bool) {
        self.alpha = enabled ? 1.0 : self.disabledStateAlpha
        self.isUserInteractionEnabled = enabled
    }
    
}
