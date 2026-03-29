//
//  AllNftRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 24.03.2026.
//

import Foundation

struct AllNftRequest: NetworkRequest {
    var page: Int
    var endpoint: URL? {
        var components = URLComponents(string:"\(RequestConstants.baseURL)/api/v1/nft")
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
        ]
    
        return components?.url
    }
}
