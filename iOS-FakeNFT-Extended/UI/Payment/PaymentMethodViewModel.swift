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
}
