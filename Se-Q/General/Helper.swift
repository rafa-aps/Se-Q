//
//  Helper.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

struct Helper {
    static func keyboardObserver(_ vc: UIViewController, selectorForKeyboardShow: Selector, selectorForKeyboardDismiss: Selector) {
        NotificationCenter.default.addObserver(vc, selector: selectorForKeyboardShow, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(vc, selector: selectorForKeyboardDismiss, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    static func removeKeyboardObserver(_ vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
