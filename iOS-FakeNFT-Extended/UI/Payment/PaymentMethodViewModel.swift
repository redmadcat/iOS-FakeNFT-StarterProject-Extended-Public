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
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    func load() async {
        do {
            status = .loading
            currencies = try await service.load()
            status = .success
        } catch {
            print(error.localizedDescription)
            status = .failure
        }
    }
    
    func pay(currency: Currency?) async {
        guard let currency else { return }

        do {
            status = .loading
            let response = try await service.pay(currency: currency)
            print(response)
            status = .success
            // TODO: clear cart
        } catch PaymentTransaction.failed {
            status = .failure
            // TODO: show modal
        } catch {
            print(error.localizedDescription)
            status = .failure
            // TODO: show modal
        }
    }
}
