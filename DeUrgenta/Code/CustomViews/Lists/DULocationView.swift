//
//  DULocationView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 04.04.2021.
//

import UIKit

@IBDesignable
class DULocationView: UIView {

    private let stackView = UIStackView(frame: .zero)
    
    @IBInspectable
    var addressKindSetting: String = "" {
        didSet {
            addressKind = DUAddress.Kind(rawValue: addressKindSetting) ?? .home
        }
    }
    
    @IBInspectable
    var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    @IBInspectable
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    private var addressKind: DUAddress.Kind = .home {
        didSet {
            configureIcon()
        }
    }
    private let VerticalSpacing = CGFloat(4)
    private let HorizontalSpacing = CGFloat(8)

    private(set) var icon = UIImageView(frame: .zero)
    private(set) var nameLabel = DULabel(frame: .zero)
    private(set) var descriptionLabel = DULabel(frame: .zero)
    
    private(set) var isSetup = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        guard !isSetup else { return }
        defer { isSetup = true }
        
        backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = VerticalSpacing
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        stackView.addArrangedSubview(descriptionLabel)
        
        let container = UIView(frame: .zero)
        stackView.addArrangedSubview(container)
        container.layer.cornerRadius = .buttonCornerRadius
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.inputBorder.cgColor
        
        let horizontalStack = UIStackView(frame: .zero)
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = HorizontalSpacing
        
        container.addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { make in
            make.edges.equalTo(container).inset(UIEdgeInsets(top: 9, left: 13, bottom: 9, right: 13))
        }
        
        horizontalStack.addArrangedSubview(icon)
        horizontalStack.addArrangedSubview(nameLabel)
        
        icon.snp.contentHuggingHorizontalPriority = 1000
        icon.contentMode = .center
        icon.tintColor = .lighterText
        
        descriptionLabel.snp.contentCompressionResistanceVerticalPriority = 1000
        descriptionLabel.snp.contentHuggingVerticalPriority = 1000
        
        descriptionLabel.font = AppFontPreset.formSmallLabel.font()
        descriptionLabel.textColor = .lighterText
        nameLabel.font = AppFontPreset.formTextField.font()
        nameLabel.textColor = .regularText
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.formTextFieldHeight)
        }
        nameLabel.snp.contentCompressionResistanceVerticalPriority = 1000
        nameLabel.snp.contentHuggingVerticalPriority = 1000
        nameLabel.numberOfLines = 1
        
        configureIcon()
    }
    
    private func configureIcon() {
        icon.image = UIImage.addressIcon(ofKind: addressKind)
    }

}
