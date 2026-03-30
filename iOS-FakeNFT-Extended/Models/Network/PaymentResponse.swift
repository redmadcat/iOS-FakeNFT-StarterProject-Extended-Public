//
//  PaymentResponse.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 25.03.2026.
//

struct PaymentResponse: Decodable {
    let id: String
    let orderId: String
    let success: Bool
}
