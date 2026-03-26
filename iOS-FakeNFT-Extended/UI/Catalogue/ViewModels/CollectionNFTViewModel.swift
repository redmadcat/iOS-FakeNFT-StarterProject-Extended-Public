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
    
    private(set) var likedNFTIds: Set<NFTCellModel> = []
   
    
    init(collection: CollectionModel, nfts: [NFTCellModel] = [], nflOrderService: NftOrderService){
        self.collection = collection
        self.nfts = nfts
        self.nftOrderService = nflOrderService
    }
 
    private(set) var nftsOrder: [Nft] = []
    
    func selectNft(_ nft: NFTCellModel) async {
        let urls = nft.images.compactMap { URL(string: $0) }
        
        guard !urls.isEmpty else {
            print("Нет валидных URL")
            return
        }
        
        let model = Nft(id: nft.id, images: urls)
        print("000000\(model)")
        do {
            nftsOrder = try await nftOrderService.selectNft(model)
            print(nftsOrder)
        }
        catch {
            print(error)
        }
    }
   
    func isSelected(nft: NFTCellModel) -> Bool {
        nftsOrder.contains(where: { $0.id == nft.id })
    }
    
    func toggleLike(for nft: NFTCellModel) {
        if likedNFTIds.contains(nft) {
            likedNFTIds.remove(nft)
        } else {
            likedNFTIds.insert(nft)
        }
    }
    
    func toggleSelection(for nft: NFTCellModel) async {
        let urls = nft.images.compactMap { URL(string: $0) }

        guard !urls.isEmpty else {
            print("Нет валидных URL")
            return
        }

        let model = Nft(id: nft.id, images: urls)
        do {
          nftsOrder = try await nftOrderService.remove(model)
            
        } catch {
            print(error)
        }
     
    }
    
}
