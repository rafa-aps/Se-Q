//
//  ProductDetailRouter.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation

class ProductDetailRouter {
    weak var viewController: ProductDetailViewController?

    func navToDetailProduct(product: Product) {
        let productDetailView = ProductDetailBuilder.viewController(product: product)
        viewController?.navigationController?.pushViewController(productDetailView, animated: true)
    }
    
    func navToPurchaseHistory() {
        let historyDetailView = ProfileBuilder.viewController(isUsingBackButton: true)
        viewController?.navigationController?.pushViewController(historyDetailView, animated: true)
    }
}
