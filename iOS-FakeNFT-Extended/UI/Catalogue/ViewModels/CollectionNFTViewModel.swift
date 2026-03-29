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
    let serviceAssembly: ServicesAssembly
    private let likeService: LikeService
    private let nftOrderService: NftOrderService
    private(set) var selectedIds: Set<String> = []
    private(set) var likedNFTIds: Set<String> = []
    
    init(collection: CollectionModel, nfts: [NFTCellModel] = [], serviceAssembly: ServicesAssembly){
        self.collection = collection
        self.nfts = nfts
        self.serviceAssembly = serviceAssembly
        self.likeService = serviceAssembly.likesService
        self.nftOrderService = serviceAssembly.nftOrderService
    }
    
    func selectNft(_ nft: NFTCellModel) async {
        let nftOrderService = serviceAssembly.nftOrderService
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
    
    func loadLikes() async {
        let cache = await likeService.getCache()
        likedNFTIds = Set(cache)
    }
    
    
    
    func toggleLike(for nft: NFTCellModel) async {
        do {
            _ = try await likeService.toggleLike(nft.id)
            await loadLikes()
        } catch {
            print(error)
        }
      
    }
    
    
    
}
