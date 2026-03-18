//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 18.03.2026.
//

import SwiftUI

@MainActor
@Observable
final class CartViewModel {
    var nftCards: [NftCardItem] = NftCardItem.mockItems
    var totalCount: String {
        nftCards.count.description + " NFT"
    }
    var totalPrice: String {
        nftCards.reduce(0) { $0 + $1.price }.description + " " +
        (nftCards.isEmpty ? "" : String(describing: nftCards[0].currency))
    }
                
    func remove(item: NftCardItem) {
        if let index = nftCards.firstIndex(of: item) {
            nftCards.remove(at: index)
        }
    }
}
