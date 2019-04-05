//
//  CollectionInfo.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/17/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation

struct CollectionInfo: Codable {
    
    let title: String
    let productType: String
    let variants: [VariantsInfo]
    let image: ImageInfo
    
    enum CodingKeys: String, CodingKey {
        case title
        case productType = "product_type"
        case variants
        case image
    }
    
}
