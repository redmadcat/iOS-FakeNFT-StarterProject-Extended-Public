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
    let nftOrderService: NftOrderService
    var selectedIds: Set<String> = []
    
    private(set) var likedNFTIds: Set<NFTCellModel> = []
    
    init(collection: CollectionModel, nfts: [NFTCellModel] = [], nflOrderService: NftOrderService){
        self.collection = collection
        self.nfts = nfts
        self.nftOrderService = nflOrderService
    }
    
    func selectNft(_ nft: NFTCellModel) async {
        let urls = nft.images.compactMap { URL(string: $0) }
        
        guard !urls.isEmpty else {
            print("Нет валидных URL")
            return
        }
        let model = Nft(id: nft.id, images: urls)
        do {
            _ = try await nftOrderService.selectNft(model)
            await loadSelected()
        }
        catch {
            print(error)
        }
    }
    func loadSelected() async {
        let cache = await nftOrderService.getCache()
        selectedIds = Set(cache.map { $0.id })
    }
    
    
    
    func toggleLike(for nft: NFTCellModel) {
        if likedNFTIds.contains(nft) {
            likedNFTIds.remove(nft)
        } else {
            likedNFTIds.insert(nft)
        }
    }
    
    
    
}
