//
//  NftPutOrderRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 20.03.2026.
//

import Foundation

struct NftPutOrderRequest: NetworkRequest {
    let nfts: [String]
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    
    var httpMethod: HttpMethod { .put }
    
    var body: Data? {
        nfts.map { "nfts=\($0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0)" }
            .joined(separator: "&").data(using: .utf8)
    }
}
