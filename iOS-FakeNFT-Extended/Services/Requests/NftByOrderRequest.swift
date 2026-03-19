//
//  NftByOrderRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 19.03.2026.
//

import Foundation

struct NftByOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}
