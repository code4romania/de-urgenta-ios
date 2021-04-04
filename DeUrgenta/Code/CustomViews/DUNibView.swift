//
//  DUNibView.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 03.04.2021.
//

import UIKit

/**
 * `DUNibView` is a UIView subclass useful for rendering
 * custom views in storyboard/xibs.
 *
 * Usage:
 * 1. Create a view class by subclassing `DUNibView`
 * 2. Create a .xib with the same name as the class (just the usual stuff)
 * 3. Set the File's Owner to the newly created class (!!! do not modify the class of the root view from the .xib)
 * 4. Link the outlets/actions to the File's Owner.
 * 5. When you want to add this view as a subclass in a storyboard/xib:
 *    a. In IB, add a new UIView
 *    b. Set its class to your custom view's class
 *    c. It should render it (after some IB build time)
 * 6. Have fun!
 *
 * *Note*: The use of this approach is quite heavyweight, because
 * IB needs to build the whole project in order to render such views.
 * Thus, you might find convenient to disable Auto Refresh Views for
 * very large storyboard/xib files and refresh IB manually instead.
 *
 * *Note 2*: The resulting view hierarchy is the following:
 * - parentView (in containing storyboard/xib)
 *    - UIView whose class we are setting to the custom view (the view added in storyboard at step 5)
 *         - the root view from xib.
 * So there is an intermediate view, compared to the usual view hierarchy
 * when loading xibs. Basically, `DUNibView` is a UIView which loads a
 * xib's content and adds it as a subview of itself.
 */
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

