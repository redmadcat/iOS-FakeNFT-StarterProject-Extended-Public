//
//  Currency.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import Foundation

struct Currency: Decodable, Identifiable {
    let id: String
    let name: String
    let image: URL
    let title: String
}
