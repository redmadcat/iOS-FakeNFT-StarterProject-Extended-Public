import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let collectionsStorage: CollectionsStorage
    private let allNftsStorage: AllNftStorage
    private let nftOrderStorage: NftOrderStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage = NftStorageImpl(),
        collectionsStorage: CollectionsStorage = CollectionsStorageImpl(),
        allNftsStorage: AllNftStorage = AllNftStorageImpl(),
        nftOrderStorage: NftOrderStorage = NftOrderStorageImpl()
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.collectionsStorage = collectionsStorage
        self.allNftsStorage = allNftsStorage
        self.nftOrderStorage = nftOrderStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    var collectionsService: CollectionsService {
        CollectionsServiceImpl(
            networkClient: networkClient,
            storage: collectionsStorage
        )
    }
    var allNftsService: AllNftService {
        AllNftServiceImpl(
            networkClient: networkClient,
            storage: allNftsStorage
        )
    }
    var nftOrderService: NftOrderService {
        NftOrderServiceImpl(
            networkClient: networkClient,
            storage: nftOrderStorage
        )
    }
    
}
