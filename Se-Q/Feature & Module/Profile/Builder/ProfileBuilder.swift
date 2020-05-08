//
//  ProfileBuilder.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

struct ProfileBuilder {
    static func viewController(isUsingBackButton: Bool) -> UIViewController {
        let viewModel = ProfileViewModel()
        let router = ProfileRouter()
        let viewController = ProfileViewController(viewModel: viewModel, router: router, isUsingBackButton: isUsingBackButton)
        router.viewController = viewController
        return viewController
    }
}
