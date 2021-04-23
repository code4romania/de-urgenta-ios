//
//  DUFormMessageView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 04.04.2021.
//

import UIKit
import SnapKit

@IBDesignable
class DUFormMessageView: UIView {

    enum MessageType: String {
        case success
        case error
    }
    
    var messageType: MessageType = .success {
        didSet {
            update()
        }
    }
    
    @IBInspectable
    var messageTypeString: String = "" {
        didSet {
            messageType = MessageType(rawValue: messageTypeString) ?? .success
        }
    }
    
    @IBInspectable
    var message: String = ""
    
    private let StackSpacing: CGFloat = 10
    
    private var icon = UIImageView(frame: .zero)
    private var label = DULabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = StackSpacing
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        stack.addArrangedSubview(icon)
        icon.snp.contentHuggingHorizontalPriority = 1000
        icon.snp.contentCompressionResistanceVerticalPriority = 1000

        stack.addArrangedSubview(label)
        label.snp.contentHuggingVerticalPriority = 999
        label.snp.contentCompressionResistanceVerticalPriority = 1000
        
        icon.contentMode = .center
        label.font = AppFontPreset.formConfirmationMessage.font()
        label.numberOfLines = 0
        
        update()
    }
    
    private func update() {
        switch messageType {
        case .success:
            icon.image = .successMessageIcon
            icon.tintColor = .successMessageForeground
            label.textColor = .successMessageForeground
        case .error:
            // TODO:
            icon.image = .successMessageIcon
            icon.tintColor = .errorMessageForeground
            label.textColor = .errorMessageForeground
        }
        
        label.text = message
    }
}
