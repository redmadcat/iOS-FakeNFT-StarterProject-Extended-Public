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
    private(set) var nfts: [Nft] = []
    private(set) var status: APIResponseStatus = .default
    private var service: NftOrderService
    
    init(service: NftOrderService) {
        self.service = service
    }
    
    var totalCount: String {
        nfts.count.description + " NFT"
    }
    
    var totalPrice: String {
        let price = nfts.reduce(0) { $0 + $1.price }
        return String(format: "%.2f", price) + " " + (nfts.isEmpty ? "" : "ETH")
    }
    
    var noItems: Bool {
        (status == .success ||
         status == .failure) && nfts.isEmpty
    }
    
    var actionAvailability: Bool {
        nfts.isEmpty
    }
    
    func sort(predicate: sortBy) async {
        nfts = await service.sort(predicate)
    }
    
    func remove(item: Nft) async {
        do {
            status = .loading
            nfts = try await service.remove(item)
            status = .success
        } catch {
            print(error)
            status = .failure
        }
    }
    
    func load() async {
        do {
            status = .loading
            nfts = try await service.load()
            status = .success
        } catch {
            print(error)
            status = .failure
        }
    }
}
