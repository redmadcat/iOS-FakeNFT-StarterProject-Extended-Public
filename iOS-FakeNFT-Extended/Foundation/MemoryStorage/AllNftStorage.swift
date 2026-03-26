//
//  AllNftStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 26.03.2026.
//

import Foundation

protocol AllNftStorage: AnyObject {
    func saveNft(_ nft: [NFTCellModel]) async
    func getNft() async -> [NFTCellModel]
}


actor AllNftStorageImpl: AllNftStorage {
    
    private var storage: [NFTCellModel] = []
    
    func saveNft(_ nft: [NFTCellModel]) async {
        let existingIds = Set(storage.map { $0.id })
        let newItems = nft.filter { !existingIds.contains($0.id) }
        
        storage.append(contentsOf: newItems)
    }
    
    func getNft() async -> [NFTCellModel] {
        storage
    }
}
