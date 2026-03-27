//
//  NtfOrderStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 22.03.2026.
//

import Foundation

protocol NftOrderStorage: AnyObject {
    func save(_ nft: Nft) async
    func remove(_ nft: Nft) async
    func clear() async
    var cache: [Nft] { get async }
   
}

actor NftOrderStorageImpl: NftOrderStorage {
    private(set) var cache: [Nft] = []
    
    func save(_ nft: Nft) async {
        cache.append(nft)
    }
        
    func remove(_ nft: Nft) async {
        cache.removeAll(where: { $0.id == nft.id })
    }
    
    func clear() async {
        cache.removeAll()
    }
}
