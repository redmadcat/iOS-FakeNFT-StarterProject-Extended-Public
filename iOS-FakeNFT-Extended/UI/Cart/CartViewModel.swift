//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 18.03.2026.
//

import SwiftUI

enum sortBy {
    case price
    case rating
    case name
}

@MainActor
@Observable
final class CartViewModel {
    private(set) var nftCards: [Nft] = []
    private(set) var status: APIResponseStatus = .default
        
    var totalCount: String {
        nftCards.count.description + " NFT"
    }
    
    var totalPrice: String {
        let price = nftCards.reduce(0) { $0 + $1.price }
        return String(format: "%.2f", price) + " " + (nftCards.isEmpty ? "" : "ETH")
    }
    
    var noItems: Bool {
        status == .success && nftCards.isEmpty ||
        status == .failure
    }
    
    var actionAvailability: Bool {
        nftCards.isEmpty
    }
    
    func sort(predicate: sortBy) {
        nftCards = nftCards.sorted {
            switch predicate {
            case .price:
                $0.price < $1.price
            case .rating:
                $0.rating > $1.rating
            case .name:
                $0.name < $1.name
            }
        }
    }
    
    func remove(item: Nft) {
        nftCards.removeAll(where: { $0.id == item.id })
    }
    
    func load() async {
        var result: NftOrder
        do {
            status = .loading
            result = try await DefaultNetworkClient().send(request: NftByOrderRequest())
            let nfts = result.nfts.isEmpty ? NftOrder.mock : result.nfts
            
            nftCards.removeAll()
            
            for id in nfts {
                let nft: Nft = try await DefaultNetworkClient().send(request: NFTRequest(id: id))
                nftCards.append(nft)
            }
            status = .success
        } catch {
            print(error)
            status = .failure
        }
    }
}
