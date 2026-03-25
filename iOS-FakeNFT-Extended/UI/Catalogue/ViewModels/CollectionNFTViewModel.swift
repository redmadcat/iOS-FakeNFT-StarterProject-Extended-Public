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
    var nfts: [NFTCellModel] = []
    
    private(set) var likedNFTIds: Set<NFTCellModel> = []
    private(set) var selectedNFTIds: Set<NFTCellModel> = []
    
    init(collection: CollectionModel, nfts: [NFTCellModel] = []){
        self.collection = collection
        self.nfts = nfts
    }
   
    
    func toggleLike(for nft: NFTCellModel) {
        if likedNFTIds.contains(nft) {
            likedNFTIds.remove(nft)
        } else {
            likedNFTIds.insert(nft)
        }
    }
    
    func toggleSelection(for nft: NFTCellModel) {
        if selectedNFTIds.contains(nft) {
            selectedNFTIds.remove(nft)
        } else {
            selectedNFTIds.insert(nft)
        }
    }
}
