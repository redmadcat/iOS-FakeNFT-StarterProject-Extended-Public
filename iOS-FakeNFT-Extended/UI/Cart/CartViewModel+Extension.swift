//
//  CartViewModel+Extension.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 25.03.2026.
//

extension CartViewModel: Hashable {
    nonisolated static func == (lhs: CartViewModel, rhs: CartViewModel) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
