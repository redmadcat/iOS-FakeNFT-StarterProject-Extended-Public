//
//  PaymentMethodViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI

@MainActor
@Observable
final class PaymentMethodViewModel {
    private(set) var currencies: [Currency] = []
    private(set) var status: APIResponseStatus = .default
    private let service: CurrencyService
    var forceRefresh: Bool = true
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    var isLoading: Bool {
        status == .loading
    }
    
    func load() async {
        defer { forceRefresh = true }
        if !forceRefresh { return }
        
        do {
            status = .loading
            currencies = try await service.load()
            status = .success
        } catch {
            print(error.localizedDescription)
            status = .failure
        }
    }
    
    func pay(parent: CartViewModel, currency: Currency?, completion: (Bool) -> Void) async {
        defer { status = .success }
        
        status = .loading
        await parent.pay(currency: currency) { failureStatus in
            if failureStatus {
                completion(failureStatus)
                status = .failure
            } else {
                status = .success
                Router.shared.toPaymentResult()
            }
        }
    }
}
