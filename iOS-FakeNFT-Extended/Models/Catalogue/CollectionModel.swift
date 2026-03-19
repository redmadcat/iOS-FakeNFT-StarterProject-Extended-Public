//
//  NFTCollectionsModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 18.03.2026.
//

import Foundation

struct CollectionModel: Codable, Identifiable, Sendable {
    let createdAt: String
    let name: String
    let cover: String
    let ntfs: [String]
 
    let description: String
    let author: String
    let website: String
    let id: String
    
    static let mock: [CollectionModel] = [
        CollectionModel(
            createdAt: "2026-03-18T12:34:56Z",
            name: "Peach",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png",
            ntfs: ["1", "2", "3"],
            description: "A collection of my favorite NFTs. nnjjnjnjnnjnjnjnjnjnjnjnnjnjnjnjnjnjnjnjnjnjnnjnjnjnjnjnjn",
            author: "Tom Smith",
            website: "https://example.com",
            id: "1"
        )
        ,
        CollectionModel(
            createdAt: "2026-03-18T12:34:56Z",
            name: "Another Collection",
            cover: "https://avatars.mds.yandex.net/i?id=3875e451275d24b5ab76574535885efb4de5f829-5231626-images-thumbs&n=13",
            ntfs: ["4", "5", "6"],
            description: "Another collection of NFTs.",
            author: "Anonymous",
            website: "n/a",
            id: "2"
        ),
        CollectionModel(
            createdAt: "2026-03-18T12:34:56Z",
            name: "Third Collection",
            cover: "https://avatars.mds.yandex.net/i?id=fca6db2f16c4805436dc919c99c798925cc0ac72-2994189-images-thumbs&n=13",
            ntfs: ["10", "11", "12"],
            description: "Yet another collection of NFTs.",
            author: "Jane Doe",
            website: "https://example.com",
            id: "3"
        )
    ]
}
