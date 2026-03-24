//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

protocol CurrencyService {
    func load() async throws -> [Currency]
    func pay(currency: Currency) async throws -> PaymentResponse
}

@MainActor
final class CurrencyServiceImpl: CurrencyService {
    private let networkClient: NetworkClient
    private let storage: CurrencyStorage

    init(networkClient: NetworkClient, storage: CurrencyStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }

    func load() async throws -> [Currency] {
        let result: [Currency] = try await networkClient.send(request: CurrencyGetRequest())
                        
        await storage.clear()
        
        for currency in result {
            await storage.save(currency)
        }
        return await storage.cache
    }
    
    func pay(currency: Currency) async throws -> PaymentResponse {
        let request = PaymentRequest(currencyId: currency.id)
        let response: PaymentResponse = try await networkClient.send(request: request)
        
        guard response.success else {
            throw PaymentTransaction.failed
        }
        
        return response
    }
}
