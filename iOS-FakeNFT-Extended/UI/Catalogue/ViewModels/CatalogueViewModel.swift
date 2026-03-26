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
   
    init(ServiceAssembly: ServicesAssembly) {
        self.serviceAssembly = ServiceAssembly
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
            print (allNfts.count)
        } catch {
            isLoadingAllNft = false
            print(error)
        }
    }
    func loadOrder() async {
        let nftOrderService = serviceAssembly.nftOrderService
        do {
            let i = try await nftOrderService.load()
            print("корзина загрузилась \(i)")
        } catch {
            print("корзина  не загрузилась")
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
    
}
