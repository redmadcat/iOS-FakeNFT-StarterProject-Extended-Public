//
//  CollectionsServise.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 21.03.2026.
//

import Foundation
protocol CollectionsService {
  // func loadCollections(page: Int, sortBy: String) async throws -> [CollectionModel]
    func loadCollections() async throws -> [CollectionModel]
 }


@MainActor
final class CollectionsServiceImpl: CollectionsService {
    
    private let networkClient: NetworkClient
    private let storage: CollectionsStorage
    init(networkClient: NetworkClient, storage: CollectionsStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }
    private let size = 25
    
    func loadCollections() async throws -> [CollectionModel] {
        var page = 0
        let size = 25
       

        while true {
            let request = CollectionsRequest(page: page)
            let collections: [CollectionModel] = try await networkClient.send(request: request)
          await  storage.saveCollections(collections)
            if collections.isEmpty {
                break
            }
        
            if collections.count < size {
                break
            }
            page += 1
        }

        return await storage.getCollections()
    }

}
