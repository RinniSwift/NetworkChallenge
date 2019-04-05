//
//  NetworkService.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/15/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation


class NetworkService {
    
    class func request<T: Codable>(router: Router, completion: @escaping ([String: [T]]) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        let session = URLSession(configuration: .default)
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            guard response != nil else {
                print("no response")
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            
            let responseObject = try! JSONDecoder().decode([String: [T]].self, from: data)
            DispatchQueue.main.async {
                completion(responseObject)
            }
        }
        dataTask.resume()
    }
}
