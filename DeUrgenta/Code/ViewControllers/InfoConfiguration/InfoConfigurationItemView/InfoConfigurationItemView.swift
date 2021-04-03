//
//  InfoConfigurationItemView.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 02.04.2021.
//

import UIKit

@objc
protocol InfoConfigurationItemViewDelegate {
    func infoConfigurationItemViewTapped(_ infoConfigurationItemView: InfoConfigurationItemView)
}

@IBDesignable
class InfoConfigurationItemView: DUNibView {
    
    @IBInspectable
    var iconImage: UIImage? {
        set { self.iconImageView.image = newValue }
        get { return self.iconImageView.image }
    }
    
    @IBInspectable
    var title: String? {
        set { self.titleLabel.text = newValue }
        get { return self.titleLabel.text }
    }
    
    @IBInspectable
    var identifier: String? = nil
    
    @IBInspectable
    var enabled: Bool = true {
        didSet {
            self.setEnabled(self.enabled)
        }
    }
    
    @IBOutlet
    weak var iconImageView: UIImageView!
    
    @IBOutlet
    weak var titleLabel: UILabel!
    
    @IBOutlet
    weak var delegate: InfoConfigurationItemViewDelegate? = nil
    
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
        self.delegate?.infoConfigurationItemViewTapped(self)
    }
    
    private func setEnabled(_ enabled: Bool) {
        self.alpha = enabled ? 1.0 : self.disabledStateAlpha
        self.isUserInteractionEnabled = enabled
    }
    
}
