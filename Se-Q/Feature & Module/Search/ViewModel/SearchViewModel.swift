//
//  SearchViewModel.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewModel {
    let products: [Product]
    let productPubSub: PublishSubject<[Product]> = PublishSubject()
    let haveDataPubSub: PublishSubject<Bool> = PublishSubject()
    
    init(products: [Product]) {
        self.products = products
    }
    
    func search(query: String) {
        var searchProduct = products
        
        if !query.isEmpty {
            searchProduct = products.filter { ($0.title?.lowercased().contains(query.lowercased()) ?? false) }
        }
        
        if searchProduct.count > 0 {
            haveDataPubSub.onNext(true)
        } else {
            haveDataPubSub.onNext(false)
        }
        
        productPubSub.onNext(searchProduct)
    }
}
