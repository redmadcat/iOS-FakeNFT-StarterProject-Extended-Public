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
    var status: APIResponseStatus = .default
    var nftCards: [Nft] = []
    var totalCount: String {
        nftCards.count.description + " NFT"
    }
    var totalPrice: String {
        let price = nftCards.reduce(0) { $0 + $1.price }
        return String(format: "%.2f", price) + " " + (nftCards.isEmpty ? "" : "ETH")
    }
    
    var emptyCart: Bool {
        status == .success && nftCards.isEmpty
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
