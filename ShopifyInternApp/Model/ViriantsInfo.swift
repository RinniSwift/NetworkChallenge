//
//  ViriantsInfo.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/17/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation

struct VariantsInfo: Codable {
    
    let title: String
    let inventoryQuantity: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case inventoryQuantity = "inventory_quantity"
    }
    
}
