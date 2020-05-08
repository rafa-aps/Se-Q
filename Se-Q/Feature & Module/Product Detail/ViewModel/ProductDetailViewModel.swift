//
//  ProductDetailViewModel.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import RxSwift
import UIKit
import CoreData

class ProductDetailViewModel {
    private var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    let productPubSub: PublishSubject<Product> = PublishSubject()
    let canBuyNow: PublishSubject<Bool> = PublishSubject()
    let likeButton: PublishSubject<Bool> = PublishSubject()
    
    func getDetail() {
        productPubSub.onNext(product)
    }
    
    func saveToHistory() {
        if !(retrieve().contains(where: { (product) -> Bool in
            
            if Int(product.id ?? "") ?? 0 == Int(self.product.id ?? "") ?? 0 {
                return true
            }
            
            return false
        })) {
            create()
            canBuyNow.onNext(true)
        } else {
            canBuyNow.onNext(false)
        }
    }
    
    func likeButtonPush() {
        let productLoved = product.loved == 0 ? false : true
        if productLoved {
            likeButton.onNext(false)
        } else {
            likeButton.onNext(true)
        }
    }
    
    func create(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "ProductData", in: managedContext)
        
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(product.id, forKey: "id")
        insert.setValue(product.imageUrl, forKey: "imageUrl")
        insert.setValue(product.loved, forKey: "loved")
        insert.setValue(product.price, forKey: "price")
        insert.setValue(product.description, forKey: "prodDescription")
        insert.setValue(product.title, forKey: "title")
        
        do{
            try managedContext.save()
        }catch let err{
            print(err)
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
