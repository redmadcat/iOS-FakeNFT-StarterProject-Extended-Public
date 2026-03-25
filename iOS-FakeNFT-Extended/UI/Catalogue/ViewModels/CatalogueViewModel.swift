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
  //  private  var page: Int = 0
 //   private var sortBy: String = "name,asc"
    init(collectionsService: CollectionsService) {
        self.collectionsService = collectionsService
    }
    private(set) var collections: [CollectionModel] = []
 
    private var isLoading = false
    
//    let sortByName = "name,asc"
   // let sortByCount = "nfts,desc"
 
    func loadCollections() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
      
        
        do {
//            let newCollections = try await collectionsService.loadCollections(page: page, sortBy: sortBy)
            let newCollections = try await collectionsService.loadCollections()
            
            if newCollections.isEmpty {
                return
            }
            
            collections.append(contentsOf: newCollections)
            print(newCollections)
          //  print("page:", page, "count:", newCollections.count)
           // page += 1
            
        } catch {
            if Task.isCancelled { return }
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
}
