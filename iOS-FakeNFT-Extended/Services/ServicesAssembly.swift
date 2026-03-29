import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let collectionsStorage: CollectionsStorage
    private let allNftsStorage: AllNftStorage
    private let nftOrderStorage: NftOrderStorage
    private let likesStorage: LikesStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage = NftStorageImpl(),
        collectionsStorage: CollectionsStorage = CollectionsStorageImpl(),
        allNftsStorage: AllNftStorage = AllNftStorageImpl(),
        nftOrderStorage: NftOrderStorage = NftOrderStorageImpl(),
        likesStorage: LikesStorage = LikesStorageImpl()
        
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.collectionsStorage = collectionsStorage
        self.allNftsStorage = allNftsStorage
        self.nftOrderStorage = nftOrderStorage
        self.likesStorage = likesStorage
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
    var likesService: LikeService {
        LikeServiceImpl(
            networkClient: networkClient,
            storage: likesStorage
        )
    }
    
}
