//
//  NftCardItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI

final class NftCardItem: Identifiable, Equatable {
    private(set) var id: UUID?
    var name: String
    var rating: Int
    var image: String
    var price: Double
    var currency: Currency
    var ratingImage: String {
        switch rating {
        case 1: return "Rating1"
        case 2: return "Rating2"
        case 3: return "Rating3"
        case 4: return "Rating4"
        case 5: return "Rating5"
        default:
            return "Rating0"
        }
    }
    
    init(id: UUID?,
         name: String,
         rating: Int,
         image: String,
         price: Double,
         currency: Currency)
    {
        self.id = id
        self.name = name
        self.rating = rating
        self.image = image
        self.price = price
        self.currency = currency
    }
    
    static func == (lhs: NftCardItem, rhs: NftCardItem) -> Bool {
        return lhs.id == rhs.id
    }
        
    static let mockItems = [
        NftCardItem(id: UUID(), name: "April", rating: 1, image: "April", price: 1.78, currency: .ETH),
        NftCardItem(id: UUID(), name: "Greena", rating: 3, image: "Greena", price: 1.78, currency: .ETH),
        NftCardItem(id: UUID(), name: "Spring", rating: 5, image: "Spring", price: 1.78, currency: .ETH)
    ]
}

