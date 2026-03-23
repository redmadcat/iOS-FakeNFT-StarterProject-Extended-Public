//
//  NFTCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 18.03.2026.
//

import Foundation

struct NFTCellModel: Decodable, Identifiable, Sendable , Hashable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let website: String
    let id: String
    
    static let mock = [NFTCellModel(
        createdAt: "2026-03-18T20:15:30Z",
        name: "Ruby",
        images: [
            "https://avatars.mds.yandex.net/i?id=9b49fc41c169d5c20a3e71d5cae1934ab2f2710e-4182781-images-thumbs&n=13"
        ],
        rating: 4,
        description: "Очень крутой NFT, купи срочно",
        price: 12.5,
        author: "Peach",
        website: "https://peach.com",
        id: "1"
    ),
                       NFTCellModel(
                        createdAt: "2026-03-18T20:15:30Z",
                        name: "Ruby",
                        images: [
                            "https://avatars.mds.yandex.net/i?id=9b49fc41c169d5c20a3e71d5cae1934ab2f2710e-4182781-images-thumbs&n=13"
                        ],
                        rating: 4,
                        description: "Очень крутой NFT, купи срочно",
                        price: 12.5,
                        author: "Peach",
                        website: "https://peach.com",
                        id: "2"
                       ),
                       NFTCellModel(
                        createdAt: "2026-03-18T20:15:30Z",
                        name: "Ruby",
                        images: [
                            "https://avatars.mds.yandex.net/i?id=9b49fc41c169d5c20a3e71d5cae1934ab2f2710e-4182781-images-thumbs&n=13"
                        ],
                        rating: 4,
                        description: "Очень крутой NFT, купи срочно",
                        price: 12.5,
                        author: "Peach",
                        website: "https://peach.com",
                        id: "3"
                       ),NFTCellModel(
                        createdAt: "2026-03-18T20:15:30Z",
                        name: "Ruby",
                        images: [
                            "https://avatars.mds.yandex.net/i?id=9b49fc41c169d5c20a3e71d5cae1934ab2f2710e-4182781-images-thumbs&n=13"
                        ],
                        rating: 4,
                        description: "Очень крутой NFT, купи срочно",
                        price: 12.5,
                        author: "Peach",
                        website: "https://peach.com",
                        id: "4"
                       )]
}
