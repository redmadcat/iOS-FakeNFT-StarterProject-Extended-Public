//
//  LikeService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 27.03.2026.
//

import Foundation

protocol LikeService {
    func load() async throws -> [String]
    func addLike(_ nftId: String) async throws -> [String]
    func removeLike(_ nftId: String) async throws -> [String]
    func toggleLike(_ nftId: String) async throws -> Bool
    func getCache() async -> [String]
}

@MainActor
final class LikeServiceImpl: LikeService {
    private let networkClient: NetworkClient
    private let storage: LikesStorage
    
    init(networkClient: NetworkClient, storage: LikesStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }
    
    
    func load() async throws -> [String] {
        let profile: UserProfile = try await networkClient.send(request: UserProfileGetRequest())
        let likes = profile.likes
        await storage.saveLikes(likes)
        print("Loaded likes: \(likes)")
        return likes
    }
    
    func addLike(_ nftId: String) async throws -> [String] {
        await storage.addLike(nftId)
        let currentLikes = await storage.getLikes()
        
        do {
            let request = UserProfilePutRequest(likes: currentLikes)
            let updatedProfile: UserProfile = try await networkClient.send(request: request)
            await storage.saveLikes(updatedProfile.likes)
            print("Added like: \(nftId), new likes: \(updatedProfile.likes)")
            return await storage.getLikes()
        } catch {
            await storage.removeLike(nftId)
            print("Failed to add like, rolled back: \(error)")
            throw error
        }
    }
    
    func removeLike(_ nftId: String) async throws -> [String] {
        await storage.removeLike(nftId)
        let currentLikes = await storage.getLikes()
        do {
            let request = UserProfilePutRequest(likes: currentLikes)
            let updatedProfile: UserProfile = try await networkClient.send(request: request)
            await storage.saveLikes(updatedProfile.likes)
            print("Removed like: \(nftId), new likes: \(updatedProfile.likes)")
            return await storage.getLikes()
        } catch {
            await storage.addLike(nftId)
            print("Failed to remove like, rolled back: \(error)")
            throw error
        }
    }
    
    func toggleLike(_ nftId: String) async throws -> Bool {
        let wasLiked = await storage.getLikes().contains(nftId)
        let isNowLiked = await storage.toggleLike(nftId)
        let currentLikes = await storage.getLikes()
        
        do {
            let request = UserProfilePutRequest(likes: currentLikes)
            let updatedProfile: UserProfile = try await networkClient.send(request: request)
            await storage.saveLikes(updatedProfile.likes)
            print("Toggled like: \(nftId), is now liked: \(isNowLiked), likes: \(updatedProfile.likes)")
            return isNowLiked
        } catch {
            if wasLiked {
                await storage.addLike(nftId)
            } else {
                await storage.removeLike(nftId)
            }
            print("Failed to toggle like, rolled back: \(error)")
            throw error
        }
    }
    
    func getCache() async -> [String] {
        return await storage.getLikes()
    }
}
