//
//  CollectionsStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 21.03.2026.
//

import Foundation
protocol CollectionsStorage: AnyObject {
    func saveCollections(_ collection: [CollectionModel]) async
    func getCollections() async -> [CollectionModel]
}

// Пример простого актора, который сохраняет данные из сети
actor CollectionsStorageImpl: CollectionsStorage {
    private var storage: [CollectionModel] = []
    
    func saveCollections(_ collection: [CollectionModel]) async {
        let existingIds = Set(storage.map { $0.id })
          let newItems = storage.filter { !existingIds.contains($0.id) }
          storage.append(contentsOf: newItems)
    }
    func clearCollections() {
        storage.removeAll()
    }
    func getCollections() async -> [CollectionModel] {
        storage
    }
}
