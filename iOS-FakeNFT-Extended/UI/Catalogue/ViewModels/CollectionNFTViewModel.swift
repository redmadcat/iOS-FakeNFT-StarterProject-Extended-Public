//
//  CollectionNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 19.03.2026.
//

import Foundation
@MainActor
@Observable

final class CollectionNFTViewModel {
    
    var collection: CollectionModel
    var ntfs: [NFTCellModel]
    
    private(set) var likedNFTIds: Set<String> = []
    private(set) var selectedNFTIds: Set<String> = []
    
    init(collection: CollectionModel, ntfs: [NFTCellModel]){
        self.collection = collection
        self.ntfs = ntfs
    }
    
    func toggleLike(for nft: NFTCellModel) {
        if likedNFTIds.contains(nft.id) {
            likedNFTIds.remove(nft.id)
        } else {
            likedNFTIds.insert(nft.id)
        }
    }
    
    func toggleSelection(for nft: NFTCellModel) {
        if selectedNFTIds.contains(nft.id) {
            selectedNFTIds.remove(nft.id)
        } else {
            selectedNFTIds.insert(nft.id)
        }
    }
}
