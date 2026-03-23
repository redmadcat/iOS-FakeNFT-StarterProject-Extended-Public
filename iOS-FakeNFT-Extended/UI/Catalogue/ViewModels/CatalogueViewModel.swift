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
    private(set) var collections: [CollectionModel] = []
    private var currentTask: Task<Void, Never>?
    
    let sortByName = "name,asc"
    let sortByCount = "nfts,desc"
 
    func loadCollections() async {
        currentTask?.cancel()
        currentTask = Task {
            do {
                let newCollections = try await collectionsService.loadCollections(page: page, sortBy: sortBy)
                collections.append(contentsOf: newCollections)
                self.page += 1
                print(collections)
            } catch {
                if Task.isCancelled { return }
                print(error)
            }
        }
        await currentTask?.value
    }

    func loadSortByName() async {
        currentTask?.cancel()
        sortBy = sortByName
        page = 0
        collections.removeAll()
        await loadCollections()
    }

    func loadSortByCount() async {
        currentTask?.cancel()
        sortBy = sortByCount
        page = 0
        collections.removeAll()
        await loadCollections()
    }
}
