//
//  PaymentRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 25.03.2026.
//

import Foundation

struct PaymentRequest: NetworkRequest {
    let currencyId: String
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currencyId)")
    }
    
    var httpMethod: HttpMethod { .get }
}
