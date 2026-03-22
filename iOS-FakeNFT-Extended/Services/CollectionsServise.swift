//
//  CollectionsServise.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 21.03.2026.
//

import Foundation
protocol CollectionsService {
   func loadCollections(page: Int, sortBy: String?) async throws -> [CollectionModel]
}

@MainActor
final class CollectionsServiceImpl: CollectionsService {
    
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCollections(page: Int, sortBy: String? = nil) async throws -> [CollectionModel] {
        let request = CollectionsByldRequest(page: page, sortBy: sortBy)
        let collections: [CollectionModel]  = try await networkClient.send(request: request)
        print (collections.count)
         return collections
    }
}
