//
//  ProfileViewModel.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

struct ProfileViewModel {
    
    let haveProductPubSub: PublishSubject<Bool> = PublishSubject()
    let productPubSub: PublishSubject<[Product]> = PublishSubject()
    
    func getHistory() {
        if retrieve().count != 0 {
            haveProductPubSub.onNext(true)
            productPubSub.onNext(retrieve())
        } else {
            haveProductPubSub.onNext(false)
        }
    }
    
    func retrieve() -> [Product]{
        var products = [Product]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ product in
                guard
                    let id = product.value(forKey: "id") as? String,
                    let imageUrl = product.value(forKey: "imageUrl") as? String,
                    let title = product.value(forKey: "title") as? String,
                    let description = product.value(forKey: "prodDescription") as? String,
                    let price = product.value(forKey: "price") as? String,
                    let loved = product.value(forKey: "loved") as? Int64
                else {
                    return
                }
                let lovedInt = Int(loved)
                products.append(
                    Product(
                        id: id, imageUrl: imageUrl, title: title, description: description, price: price, loved: lovedInt)
                )
            }
        }catch let err{
            print(err)
        }
        
        return products
    }
}

