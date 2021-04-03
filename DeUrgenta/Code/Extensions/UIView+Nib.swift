//
//  UIView+Nib.swift
//  DeUrgenta
//
//  Created by Vlad Rusu on 03.04.2021.
//

import UIKit

extension UIView {
    
    class func loadFromNib(owner: Any? = nil) -> Self {
        let nibName = String(describing: Self.self)
        let bundle = Bundle(for: Self.self)
        return bundle.loadNibNamed(nibName, owner: owner, options: nil)?.first as! Self
    }
}
