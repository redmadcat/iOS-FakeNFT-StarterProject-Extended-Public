//
//  CatalogueViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 19.03.2026.
//

import Foundation
@MainActor
@Observable

final class CatalogueViewModel{
     let serviceAssembly: ServicesAssembly
    let collectionsService: CollectionsService
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        self.collectionsService = serviceAssembly.collectionsService
    }
    
    private(set) var collections: [CollectionModel] = []
    private(set) var allNfts: [NFTCellModel] = []
    var nftsCollection : [NFTCellModel] = []
    private var isLoadingCollection = false
    private var isLoadingAllNft = false

 
    func loadCollections() async {
        let collectionsService = serviceAssembly.collectionsService
        guard !isLoadingCollection else { return }
        isLoadingCollection = true
        do {
            let newCollections = try await collectionsService.loadCollections()
            collections = newCollections
        } catch {
          isLoadingCollection = false
            print(error)
        }
    }
    
    func loadAllNfts() async {
        let allNftsService = serviceAssembly.allNftsService
        guard !isLoadingAllNft else { return }
        
        isLoadingAllNft = true
      
        do {
            let newNfts = try await allNftsService.loadAllNft()
            allNfts = newNfts
        } catch {
            isLoadingAllNft = false
            print(error)
        }
    }
    func loadOrder() async {
        let nftOrderService = serviceAssembly.nftOrderService
        do {
            _ = try await nftOrderService.load()
           
        } catch {
            print(error)
        }
    }

    func sortByName() async {
        collections.sort { $0.name.lowercased() < $1.name.lowercased() }
    }

    func sortByCount() async {
        collections.sort { $0.nfts.count > $1.nfts.count }
    }
    
  
        func mapNftsToCollection(collection: CollectionModel) -> [NFTCellModel] {
            let ids = Set(collection.nfts)
            let result = allNfts.filter { ids.contains($0.id) }
            return result
        
    }
    
    func loadUserProfile() async {
        let userService = serviceAssembly.likesService
        do{
            _ = try await userService.load()
        } catch {
            print(error)
        }
    }
    
    
}
