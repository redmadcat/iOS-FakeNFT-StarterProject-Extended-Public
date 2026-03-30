//
//  NtfOrderStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 22.03.2026.
//

import Foundation

protocol NftOrderStorage: AnyObject {
    func save(_ nft: Nft) async   
    func sort(_ predicate: NtfOrderPredicate) async -> [Nft]
    func remove(_ nft: Nft) async
    func clear() async
    var cache: [Nft] { get async }
}

actor NftOrderStorageImpl: NftOrderStorage {
    private(set) var cache: [Nft] = []
    
    func save(_ nft: Nft) async {
        cache.append(nft)
    }
        
    func sort(_ predicate: NtfOrderPredicate) async -> [Nft] {
        return cache.sorted {
            switch predicate {
            case .price:
                $0.price < $1.price
            case .rating:
                $0.rating > $1.rating
            case .name:
                $0.name < $1.name
            }
        }
    }
    
    func remove(_ nft: Nft) async {
        cache.removeAll(where: { $0.id == nft.id })
    }
    
    func clear() async {
        cache.removeAll()
    }
}
