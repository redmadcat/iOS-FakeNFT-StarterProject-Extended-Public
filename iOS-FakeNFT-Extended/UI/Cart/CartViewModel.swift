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
    var forceRefresh: Bool = true
    
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
        defer { forceRefresh = true }
        if !forceRefresh { return }
        
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
    
    func pay(currency: Currency?, completion: (Bool) -> Void) async {
        guard let currency else { return }

        do {
            status = .loading
            let response = try await service.pay(currency: currency)
            if response.success {
                await clear()
                completion(false)
            }
            status = .success
        } catch PaymentTransaction.failed {
            status = .failure
            completion(true)
        } catch {
            print(error.localizedDescription)
            status = .failure
            completion(true)
        }
    }
    
    private func clear() async {
        forceRefresh = false
        do {
            try await service.clear()
            nfts.removeAll()
        } catch {
            print(error.localizedDescription)
        }
    }
}
