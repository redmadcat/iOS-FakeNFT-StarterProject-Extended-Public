//
//  AllNftRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 24.03.2026.
//

import Foundation

struct AllNftRequest: NetworkRequest {

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft")
    }
}
