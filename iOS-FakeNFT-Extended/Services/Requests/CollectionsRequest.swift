//
//  CollectionsRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 21.03.2026.
//

import Foundation

struct CollectionsRequest: NetworkRequest {
//    var page: Int
//    var size: Int = 5
//    var sortBy: String

    var endpoint: URL? {
        var components = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/collections")
       // components?.queryItems = [
          //  URLQueryItem(name: "page", value: "\(page)"),
           // URLQueryItem(name: "size", value: "\(size)"),
           // URLQueryItem(name: "sortBy", value: sortBy)
       // ]
    
        return components?.url
    }
  
}
