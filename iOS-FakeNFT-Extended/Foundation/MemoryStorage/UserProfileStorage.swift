//
//  ProfileStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 27.03.2026.
//

import Foundation

protocol UserProfileStorage: AnyObject {
    func saveProfile(_ profile: UserProfile) async
    func getProfile() async -> UserProfile?
    func getLikes() async -> Set<String>
    func addLike(_ nftId: String) async
    func removeLike(_ nftId: String) async
    func toggleLike(_ nftId: String) async -> Bool
    func clear() async
    var cache: UserProfile? { get async }
}

actor UserProfileStorageImpl: UserProfileStorage {
 
        private(set) var cache: UserProfile?
        
        func saveProfile(_ profile: UserProfile) async {
            cache = profile
        }
        
        func getProfile() async -> UserProfile? {
            return cache
        }
        
    func getLikes() async -> Set<String> {
        return Set(cache?.likes ?? [])
    }
        
        func addLike(_ nftId: String) async {
            guard let profile = cache else { return }
            
            if !profile.likes.contains(nftId) {
                var newLikes = profile.likes
                newLikes.append(nftId)
                cache = profile.updatingLikes(newLikes)
            }
        }
        
        func removeLike(_ nftId: String) async {
            guard let profile = cache else { return }
            
            if profile.likes.contains(nftId) {
                let newLikes = profile.likes.filter { $0 != nftId }
                cache = profile.updatingLikes(newLikes)
            }
        }
        
        func toggleLike(_ nftId: String) async -> Bool {
            guard let profile = cache else { return false }
            
            let (newProfile, isLiked) = profile.togglingLike(nftId)
            cache = newProfile
            return isLiked
        }
        
        func clear() async {
            cache = nil
        }
    }
