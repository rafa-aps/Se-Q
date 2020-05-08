//
//  HomeViewModel.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var isReload = BehaviorRelay<Bool>(value: false)
    var category = BehaviorRelay<[Category]>(value: [])
    var product = BehaviorRelay<[Product]>(value: [])
    
    func getList(){
        guard let url = URL(string: Constant.baseURLHome()) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard response != nil else {
                    self.isReload.accept(true)
                    return
                }
                self.isReload.accept(false)
                let list = try JSONDecoder().decode([List].self, from: data!)
                self.category.accept(list[0].data.category)
                self.product.accept(list[0].data.productPromo)
            } catch let error {
                self.isReload.accept(true)
                print(error)
            }
        }.resume()
    }
}
