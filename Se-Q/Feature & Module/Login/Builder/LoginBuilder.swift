//
//  LoginBuilder.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

struct LoginBuilder {
    static func viewController() -> UIViewController {
        let viewModel = LoginViewModel()
        let router = LoginRouter()
        let viewController = LoginViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
