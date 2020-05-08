//
//  SearchBuilder.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

struct SearchBuilder {
    
    static func viewController(products: [Product]) -> UIViewController {
        let viewModel = SearchViewModel(products: products)
        let router = SearchRouter()
        let viewController = SearchViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
    
}
