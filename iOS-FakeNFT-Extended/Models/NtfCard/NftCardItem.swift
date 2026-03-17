//
//  NftCardItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI

enum Currency: String, CaseIterable {
    case BTC = "Bitcoin"
    case USDT = "Tether"
    case SOL = "Solana"
    case ADA = "Cardano"
    case DOGE = "Dogecoin"
    case APE = "Apecoin"
    case ETH = "Ethereum"
    case SHIB = "Shiba Inu"
}

final class NftCardItem: Identifiable {
    private(set) var id: UUID?
    var name: String
    var rating: Int
    var image: String
    var price: Double
    var currency: Currency
    
    init(id: UUID?, name: String, rating: Int, image: String, price: Double, currency: Currency) {
        self.id = id
        self.name = name
        self.rating = rating
        self.image = image
        self.price = price
        self.currency = currency
    }
    
    static let mockItems = [
        NftCardItem(id: UUID(), name: "April", rating: 1, image: "April", price: 1.78, currency: .ETH),
        NftCardItem(id: UUID(), name: "Greena", rating: 3, image: "Greena", price: 1.78, currency: .ETH),
        NftCardItem(id: UUID(), name: "Spring", rating: 5, image: "Spring", price: 1.78, currency: .ETH)
    ]
}

