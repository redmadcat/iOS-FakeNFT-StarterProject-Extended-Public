//
//  NftOrder.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 19.03.2026.
//

struct NftOrder: Decodable, Sendable {
    let id: String
    let nfts: [String]
}
