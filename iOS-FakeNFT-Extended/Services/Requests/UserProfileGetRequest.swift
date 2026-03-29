//
//  UserProfileGetRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 27.03.2026.
//

import Foundation

struct UserProfileGetRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}
