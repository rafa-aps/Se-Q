//
//  Data.swift
//  Se-Q
//
//  Created by rahman fad on 08/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import Foundation

struct Data: Decodable {
    let productPromo: [Product]
    let category: [Category]
}
