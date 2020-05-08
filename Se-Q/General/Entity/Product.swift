//
//  Product.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: String?
    let imageUrl: String?
    let title: String?
    let description: String?
    let price: String?
    let loved: Int?
}
