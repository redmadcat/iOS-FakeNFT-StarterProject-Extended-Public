//
//  CurrencyStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import Foundation

protocol CurrencyStorage: AnyObject {
    func save(_ currency: Currency) async
    func clear() async
    var cache: [Currency] { get async }
}

actor CurrencyStorageImpl: CurrencyStorage {
    private(set) var cache: [Currency] = []
                    
    func save(_ currency: Currency) async {
        cache.append(currency)
    }
        
    func clear() async {
        cache.removeAll()
    }
}
