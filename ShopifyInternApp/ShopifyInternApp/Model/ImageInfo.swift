//
//  ImageInfo.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/17/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation

struct ImageInfo: Codable {
    
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "src"
    }
    
}
