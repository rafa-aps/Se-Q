//
//  LoginRouter.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

class LoginRouter {
    weak var viewController: LoginViewController?
    
    func navToHome(){
        let navigationController = UINavigationController(rootViewController: BaseTabBarViewController())
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
