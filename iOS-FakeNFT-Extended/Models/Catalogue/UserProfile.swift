//
//  UserProfile.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 27.03.2026.
//

import Foundation

struct UserProfile: Codable, Identifiable, Sendable, Hashable {
    let name: String
    let avatar: String
    let description: String?
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
    
   
}

extension UserProfile {
    func updatingLikes(_ newLikes: [String]) -> UserProfile {
        return UserProfile(
            name: self.name,
            avatar: self.avatar,
            description: self.description,
            website: self.website,
            nfts: self.nfts,
            likes: newLikes,
            id: self.id
        )
    }
    func togglingLike(_ nftId: String) -> (newProfile: UserProfile, isLiked: Bool) {
          var newLikes = self.likes
          
          if newLikes.contains(nftId) {
              newLikes.removeAll { $0 == nftId }
              return (self.updatingLikes(newLikes), false) // лайк удален
          } else {
              newLikes.append(nftId)
              return (self.updatingLikes(newLikes), true) // лайк добавлен
          }
      }
}
