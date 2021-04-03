//
//  DUNibView.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 03.04.2021.
//

import UIKit

@IBDesignable
class DUNibView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.createNibView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.createNibView()
    }
    
    private func createNibView() {
        guard let view = self.loadFromNib() else { return }
        self.addSubview(view)
        view.frame = self.bounds
        self.backgroundColor = .clear
        self.createConstraints(for: view)
        self.setNeedsLayout()
    }
    
    private func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createConstraints(for view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

