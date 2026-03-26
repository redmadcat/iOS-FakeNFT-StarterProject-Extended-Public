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
    private let storage: AllNftStorage
    
    init(networkClient: NetworkClient, storage: AllNftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadAllNft() async throws -> [NFTCellModel] {
        
        var page = 0
        let size = 25

        while true {
            let request = AllNftRequest(page: page)
            let nfts: [NFTCellModel] = try await networkClient.send(request: request)
            print(nfts)
            await  storage.saveNft(nfts)
            print("page \(page): \(nfts.count)")
            if nfts.isEmpty {
                break
            }
            if nfts.count < size {
                break
            }
            page += 1
        }
        return await storage.getNft()
        
    }
}
