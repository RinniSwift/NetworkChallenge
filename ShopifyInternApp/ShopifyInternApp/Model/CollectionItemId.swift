//
//  CollectionItemId.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/17/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation

struct CollectionItemId: Codable {
    
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
    }
    
}
