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
    private  var page: Int = 0
    private var sortBy: String?
    init(collectionsService: CollectionsService) {
        self.collectionsService = collectionsService
    }
    
    let sortByName = "name,asc"
    let sortByCount = "nfts,desc"
    var collections: [CollectionModel] = []
    func loadCollections() async {
        do {
            let newCollections = try await collectionsService.loadCollections(page: page, sortBy: sortBy)
            collections.append(contentsOf: newCollections)
            self.page += 1
            print(collections)
        } catch {
            print(error)
            
        }
    }
    func loadSortByName() async {
        sortBy = sortByName
        page = 0
        self.collections.removeAll()
        await loadCollections()
    }
    
    func loadSortByCount() async {
        sortBy = sortByCount
        page = 0
        self.collections.removeAll()
        await loadCollections()
    }
}
