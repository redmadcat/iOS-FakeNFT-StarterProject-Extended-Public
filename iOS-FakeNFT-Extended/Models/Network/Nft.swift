import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let createdAt: String
    let name: String
    let images: [URL]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let website: String
    
    init(id: String,
         images: [URL],
         name: String = "",
         createdAt: String = "",
         rating: Int = 0,
         description: String = "",
         price: Float = 0,
         author: String = "",
         website: String = "") {
        self.id = id
        self.images = images
        self.name = name
        self.createdAt = createdAt
        self.rating = rating
        self.description = description
        self.price = price
        self.author = author
        self.website = website
    }
}
