//
//  ProductDetailBuilder.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

struct ProductDetailBuilder {
    static func viewController(product: Product) -> UIViewController {
        let viewModel = ProductDetailViewModel(product: product)
        let router = ProductDetailRouter()
        let viewController = ProductDetailViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
