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
    private(set) var nfts: [Nft] = []
    private(set) var status: APIResponseStatus = .default
    private let service: NftOrderService
    
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
    
    var isBusy: Bool {
        status == .loading
    }
    
    var noItems: Bool {
        (status == .success ||
         status == .failure) && nfts.isEmpty
    }
    
    var actionAvailability: Bool {
        nfts.isEmpty || isBusy
    }
    
    func sort(_ predicate: NtfOrderPredicate) async {
        nfts = await service.sort(predicate)
    }
    
    func remove(_ nft: Nft) async {
        do {
            status = .loading
            nfts = try await service.remove(nft)
            status = .success
        } catch {
            print(error.localizedDescription)
            status = .failure
        }
    }
    
    func load(_ predicate: NtfOrderPredicate?) async {
        do {
            status = .loading
            nfts = try await service.load()
            status = .success
                        
            guard let predicate else { return }
            await sort(predicate)
        } catch {
            print(error.localizedDescription)
            status = .failure
        }
    }
}
