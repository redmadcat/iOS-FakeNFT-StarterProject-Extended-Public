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
    
    private let collectionsService: CollectionsService
    private let allNftsService: AllNftService
  
    init(collectionsService: CollectionsService, allNftsService: AllNftService) {
        self.collectionsService = collectionsService
        self.allNftsService = allNftsService
    }
    private(set) var collections: [CollectionModel] = []
    private(set) var allNfts: [NFTCellModel] = []
    var nftsCollection : [NFTCellModel] = []
    private var isLoadingCollection = false
    private var isLoadingAllNft = false

 
    func loadCollections() async {
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

    func sortByName() async {
        collections.sort { $0.name.lowercased() < $1.name.lowercased() }
        
//        sortBy = sortByName
//        page = 0
//        collections.removeAll()
       // await loadCollections()
    }

    func sortByCount() async {
        collections.sort { $0.nfts.count > $1.nfts.count }
       // sortBy  = sortByCount
       // page = 0
       // collections.removeAll()
       // await loadCollections()
    }
    
  
        func mapNftsToCollection(collection: CollectionModel) -> [NFTCellModel] {
            let ids = Set(collection.nfts)
            
            let result = allNfts.filter { ids.contains($0.id) }
            
//            print("IDs from collection:", ids)
//            print("All NFTs count:", allNfts)
//            print("Mapped NFTs count:", result.count)
            
            return result
        
    }
    
}
