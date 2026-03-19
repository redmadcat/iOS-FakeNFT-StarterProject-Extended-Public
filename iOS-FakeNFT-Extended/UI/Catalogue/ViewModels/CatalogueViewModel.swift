//
//  CatalogueViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 19.03.2026.
//

import Foundation
@MainActor
@Observable

final class CatalogueViewModel {
   
    var collections: [CollectionModel]
 
    init(collections: [CollectionModel]) {
        self.collections = collections
    }
 
}
