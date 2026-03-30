//
//  PaymentMethodViewModel+Extension.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 25.03.2026.
//

extension PaymentMethodViewModel: Hashable {
    nonisolated static func == (lhs: PaymentMethodViewModel, rhs: PaymentMethodViewModel) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
