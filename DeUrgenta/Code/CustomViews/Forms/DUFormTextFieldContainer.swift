//
//  DUFormTextFieldContainer.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 03.04.2021.
//

import UIKit
import SnapKit

@IBDesignable
class DUFormTextFieldContainer: UIView {
    private let stackView = UIStackView(frame: .zero)
    
    enum Variant: String {
        case plain
        case email
        case password
    }
    
    @IBInspectable
    var variantSetting: String = "" {
        didSet {
            variant = Variant(rawValue: variantSetting) ?? .plain
        }
    }
    
    @IBInspectable
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    @IBInspectable
    var fieldPlaceholder: String = "" {
        didSet {
            textField.placeholder = fieldPlaceholder
        }
    }
    
    @IBInspectable
    var fieldValue: String = "" {
        didSet {
            textField.text = fieldValue
        }
    }
    
    private var variant: Variant = .plain
    private let VerticalSpacing = CGFloat(4)
    
    private(set) var textField = DUTextField(frame: .zero)
    private(set) var label = DULabel(frame: .zero)
    
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
        backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = VerticalSpacing
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        label.snp.contentCompressionResistanceVerticalPriority = 1000
        label.snp.contentHuggingVerticalPriority = 1000
        
        label.font = AppFontPreset.formSmallLabel.font()
        textField.font = AppFontPreset.formTextField.font()
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.formTextFieldHeight)
        }
        textField.borderStyle = .roundedRect
    }
    
    private func configureTextField() {
        switch variant {
        case .email:
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
        case .password:
            textField.isSecureTextEntry = true
            textField.autocapitalizationType = .none
        case .plain:
            textField.autocapitalizationType = .words
        }
    }
}
