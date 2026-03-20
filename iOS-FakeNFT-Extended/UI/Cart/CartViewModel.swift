//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 18.03.2026.
//

import SwiftUI

enum sort {
    case price
    case rating
    case name
}

@MainActor
@Observable
final class CartViewModel {
    var sortPredicate = sort.name
    var status: APIResponseStatus = .default
    var nftCards: [Nft] = []
    var nftCardsSorted: [Nft] {
        return nftCards.sorted {
            switch sortPredicate {
            case .price:
                $0.price < $1.price
            case .rating:
                $0.rating > $1.rating
            case .name:
                $0.name < $1.name
            }
        }
    }
    var totalCount: String {
        nftCards.count.description + " NFT"
    }
    var totalPrice: String {
        let price = nftCards.reduce(0) { $0 + $1.price }
        return String(format: "%.2f", price) + " " + (nftCards.isEmpty ? "" : "ETH")
    }
    
    var emptyCart: Bool {
        status == .success && nftCards.isEmpty ||
        status == .failure
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
