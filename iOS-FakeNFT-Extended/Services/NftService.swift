import Foundation

protocol NftService {
    func loadNft(id: String) async throws -> Nft
}

@MainActor
final class NftServiceImpl: NftService {

    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNft(id: String) async throws -> Nft {
        if let nft = await storage.getNft(with: id) {
            return nft
        }

        let request = NFTRequest(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        await storage.saveNft(nft)
        return nft
    }
    func testLoadNft(id: String) async {
        do {
            let nft = try await loadNft(id: id)
            print("✅ NFT получен:")
            print("\(nft.images)")
           
        } catch {
            print("❌ Ошибка при загрузке NFT:", error)
        }
    }
}
