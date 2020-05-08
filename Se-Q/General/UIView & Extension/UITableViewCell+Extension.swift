//
//  UITableViewCell+Extension.swift
//  Se-Q
//
//  Created by rahman fad on 07/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
