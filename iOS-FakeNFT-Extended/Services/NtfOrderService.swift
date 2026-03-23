//
//  NtfOrderService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 22.03.2026.
//

protocol NftOrderService {
    func load() async throws -> [Nft]
    func remove(_ ntf: Nft) async throws -> [Nft]
    func sort(_ predicate: NtfOrderPredicate) async -> [Nft]
}

@MainActor
final class NftOrderServiceImpl: NftOrderService {
    private let networkClient: NetworkClient
    private let storage: NftOrderStorage

    init(networkClient: NetworkClient, storage: NftOrderStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }

    func load() async throws -> [Nft] {
        let result: NftOrder = try await networkClient.send(request: NftGetOrderRequest())
        
        // INFO: use mock if no orders placed to simplify test
        let nfts = result.nfts.isEmpty ? NftOrder.mock : result.nfts
        
        await storage.clear()
        
        for id in nfts {
            let nft: Nft = try await networkClient.send(request: NFTRequest(id: id))
            await storage.save(nft)
        }
        return await storage.cache
    }
    
    func remove(_ ntf: Nft) async throws -> [Nft] {
        await storage.remove(ntf)
        // TODO: sprint_3 networkClient OrderPutRequest
        return await storage.cache
    }
    
    func sort(_ predicate: NtfOrderPredicate) async -> [Nft] {
        await storage.sort(predicate)
    }
}
