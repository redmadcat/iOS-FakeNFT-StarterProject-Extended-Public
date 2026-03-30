//
//  NftOrder.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 30.03.2026.
//

struct NftOrder: Decodable, Sendable {
    let id: String
    let nfts: [String]
    
    static let mock = [
        "c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
        "d6a02bd1-1255-46cd-815b-656174c1d9c0",
        "f380f245-0264-4b42-8e7e-c4486e237504"
    ]
}
