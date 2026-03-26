//
//  NftOrderService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 22.03.2026.
//

protocol NftOrderService {
    func load() async throws -> [Nft]
    func remove(_ nft: Nft) async throws -> [Nft]
   // func sort(_ predicate: NtfOrderPredicate) async -> [Nft]
   // func pay(currency: Currency) async throws -> PaymentResponse
    func clear() async throws
    func selectNft(_ nft: Nft) async throws -> [Nft]
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
                print("Saved nft: \(nft)")
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
                print("Removed nft: \(nft)")
            }
        }
                                        
        return await storage.cache
    }
    
    func selectNft(_ nft: Nft) async throws -> [Nft] {
        let current = try await load()
        var ids = current.map { $0.id }

        if ids.contains(nft.id) {
            // удаление
            ids.removeAll { $0 == nft.id }
            print("Removing \(nft.id)")
        } else {
            // добавление
            ids.append(nft.id)
            print("Adding \(nft.id)")
        }

        // ВАЖНО: отправляем даже если массив пустой
        _ = try await networkClient.send(request: NftPutOrderRequest(nfts: ids))

        // локальная синхронизация
        if ids.contains(nft.id) {
            await storage.save(nft)
        } else {
            await storage.remove(nft)
        }

        return await storage.cache
    }
//    func selectNft(_ nft: Nft) async throws -> [Nft] {
//        let nfts = try await load()
//        if !nfts.isEmpty {
//            let nftIds = nfts.filter { $0.id != nft.id }.map { $0.id }
//            
//            if !nftIds.isEmpty {
//                _ = try await networkClient.send(request: NftPutOrderRequest(nfts: nftIds))
//                await storage.remove(nft)
//                print("Removed nft: \(nft)")
//            }
//        } else {
//            _ = try await networkClient.send(request: NftPutOrderRequest(nfts: [nft.id]))
//            await storage.save(nft)
//            print("Saved nft: \(nft)")
//        }
//                                        
//        return await storage.cache
//    }
//    func sort(_ predicate: NtfOrderPredicate) async -> [Nft] {
//        await storage.sort(predicate)
//    }
//    
//    func pay(currency: Currency) async throws -> PaymentResponse {
//        let request = PaymentRequest(currencyId: currency.id)
//        let response: PaymentResponse = try await networkClient.send(request: request)
//        
//        guard response.success else {
//            throw PaymentTransaction.failed
//        }
//        
//        return response
//    }
    
    func clear() async throws {
        _ = try await networkClient.send(request: NftPutOrderRequest(nfts: []))
    }
}
