//
//  NftOrderService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 22.03.2026.
//

protocol NftOrderService {
    func load() async throws -> [Nft]
    func remove(_ nft: Nft) async throws -> [Nft]
    func selectNft(_ nft: Nft) async throws
    func getCache() async -> [Nft]
    func sort(_ predicate: NtfOrderPredicate) async -> [Nft]
    func pay(currency: Currency) async throws -> PaymentResponse
    func clear() async throws
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
        let order: NftOrder = try await networkClient.send(request: NftGetOrderRequest())
        await storage.clear()
        
        if !order.nfts.isEmpty {
            for id in order.nfts {
                let nft: Nft = try await networkClient.send(request: NFTRequest(id: id))
                await storage.save(nft)
            }
        }
                        
        return await storage.cache
    }
    
    func remove(_ nft: Nft) async throws -> [Nft] {
        let nfts = try await load()
        if !nfts.isEmpty {
            let nftIds = nfts.filter { $0.id != nft.id }.map { $0.id }
            if !nftIds.isEmpty {
                _ = try await networkClient.send(request: NftPutOrderRequest(nfts: nftIds))
                await storage.remove(nft)
            }
        }
        
        return await storage.cache
    }
    
    func selectNft(_ nft: Nft) async throws {
        let nfts = try await load()
        if nfts.contains(where: { $0.id == nft.id }) {
            let updatedNfts = nfts.filter { $0.id != nft.id }
            let updatedIds = updatedNfts.map { $0.id }
            _ = try await networkClient.send(request: NftPutOrderRequest(nfts: updatedIds))
            await storage.remove(nft)
            print("Removed NFT \(nft.id)")
        } else {
            let updatedIds = nfts.map { $0.id } + [nft.id]
            _ = try await networkClient.send(request: NftPutOrderRequest(nfts: updatedIds))
            await storage.save(nft)
            print("Added NFT \(nft.id)")
        }
    }
    
    func sort(_ predicate: NtfOrderPredicate) async -> [Nft] {
        await storage.sort(predicate)
    }
    
    func pay(currency: Currency) async throws -> PaymentResponse {
        let request = PaymentRequest(currencyId: currency.id)
        let response: PaymentResponse = try await networkClient.send(request: request)
            
        return response
    }
    
    func clear() async throws {
        _ = try await networkClient.send(request: NftPutOrderRequest(nfts: []))
    }

    func getCache() async -> [Nft] {
        await storage.cache
    }
}
