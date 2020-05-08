//
//  ProfileRouter.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation

class ProfileRouter {
    weak var viewController: ProfileViewController?
    
    func navToDetailProduct(product: Product){
        let productDetailView = ProductDetailBuilder.viewController(product: product)
        viewController?.navigationController?.pushViewController(productDetailView, animated: true)
    }
}
