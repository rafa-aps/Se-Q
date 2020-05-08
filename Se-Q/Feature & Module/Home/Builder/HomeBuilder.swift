//
//  HomeBuilder.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

struct HomeBuilder {
    static func viewController() -> UIViewController {
        let viewModel = HomeViewModel()
        let router = HomeRouter()
        let viewController = HomeViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
