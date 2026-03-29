//
//  LikesStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 27.03.2026.
//

import Foundation

protocol LikesStorage: AnyObject {
    func saveLikes(_ likes: [String]) async
    func getLikes() async -> [String]
    func addLike(_ nftId: String) async
    func removeLike(_ nftId: String) async
    func toggleLike(_ nftId: String) async -> Bool
    func clear() async
    var cache: [String] { get async }
}

actor LikesStorageImpl: LikesStorage {
    private(set) var cache: [String] = []
    
    func saveLikes(_ likes: [String]) async {
        cache = likes
    }
    
    func getLikes() async -> [String] {
        return cache
    }
    
    func addLike(_ nftId: String) async {
        if !cache.contains(nftId) {
            cache.append(nftId)
        }
    }
    
    func removeLike(_ nftId: String) async {
        cache.removeAll { $0 == nftId }
    }
    
    func toggleLike(_ nftId: String) async -> Bool {
        if cache.contains(nftId) {
            cache.removeAll { $0 == nftId }
            return false
        } else {
            cache.append(nftId)
            return true
        }
    }
    
    func clear() async {
        cache.removeAll()
    }
}
