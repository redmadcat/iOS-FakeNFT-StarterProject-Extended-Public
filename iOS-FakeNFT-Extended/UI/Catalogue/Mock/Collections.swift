//
//  Collections.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 11.03.2026.
//

import Foundation
 
struct Collections: Identifiable  {
    let id: UUID = UUID()
    let title: String
    let image: String
    let imageCount: String
    init(title: String, image: String, imageCount: String) {
        self.title = title
        self.image = image
        self.imageCount = imageCount
    }
    
    static let mock: [Collections] = [
        Collections(title: "Peach", image: "https://avatars.mds.yandex.net/i?id=34f57633c955c47b56c68537076e5bfa570e512b-5905145-images-thumbs&n=13", imageCount: "12"),
        Collections(title: "Blue", image: "https://avatars.mds.yandex.net/i?id=3875e451275d24b5ab76574535885efb4de5f829-5231626-images-thumbs&n=13", imageCount: "24"),
        Collections(title: "Brown", image: "https://avatars.mds.yandex.net/i?id=fca6db2f16c4805436dc919c99c798925cc0ac72-2994189-images-thumbs&n=13", imageCount: "36"),
    ]
}
