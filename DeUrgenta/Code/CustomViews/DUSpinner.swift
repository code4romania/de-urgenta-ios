//
//  DUSpinner.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.04.2021.
//

import UIKit
import SnapKit

class DUSpinner: UIView {
    let image = UIImage.largeSpinner?.withRenderingMode(.alwaysTemplate)
    
    var isAnimating = false {
        didSet {
            guard isAnimating != oldValue else {
                return
            }
            isAnimating ? setupAnimation() : teardownAnimation()
        }
    }
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    override func tintColorDidChange() {
        imageView.tintColor = tintColor
    }

    private func setupAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 2
        animation.repeatCount = .infinity
        imageView.layer.add(animation, forKey: "spinning")
    }
    
    private func teardownAnimation() {
        imageView.layer.removeAllAnimations()
    }
}
