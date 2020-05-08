//
//  HomeRouter.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation

class HomeRouter {
    weak var viewController: HomeViewController?
    
    func navToDetailProduct(product: Product){
        let productDetail = ProductDetailBuilder.viewController(product: product)
        viewController?.navigationController?.pushViewController(productDetail, animated: true)
    }
}
