//
//  UserProfilePutRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 27.03.2026.
//

import Foundation

struct UserProfilePutRequest: NetworkRequest {
    let likes: [String]
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    
    var httpMethod: HttpMethod { .put }
    var body: Data? {
        let likesParams = likes.map { "likes=\($0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0)" }
        print("📤 Sending likes: \(likesParams.joined(separator: "&"))")
        return likesParams.joined(separator: "&").data(using: .utf8)
    }
}
