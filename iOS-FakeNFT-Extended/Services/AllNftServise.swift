//
//  AllNftServise.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 24.03.2026.
//

import Foundation
protocol AllNftService {
    func loadAllNft() async throws -> [NFTCellModel]
}

@MainActor
final class AllNftServiceImpl: AllNftService {

    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadAllNft() async throws -> [NFTCellModel] {
//        if let nft = await storage.getNft(with: id) {
//            return nft
//        }

        let request = AllNftRequest()
        let allNft: [NFTCellModel] = try await networkClient.send(request: request)
       // await storage.saveNft(nft)
        return allNft
    }
}
