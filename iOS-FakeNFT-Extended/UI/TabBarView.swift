import SwiftUI

struct TabBarView: View {
    @State private var router = Router.shared
    @State private var vm: CatalogueViewModel
    private let serviceAssembly = ServicesAssembly(networkClient: DefaultNetworkClient())
     
    init() {
        vm = CatalogueViewModel(serviceAssembly: serviceAssembly)
    }
    
    var body: some View {
        NavigationStack(path: $router.endpoint) {
            TabView {
                CatalogueView(vm: vm)
                    .tabItem {
                        Image(.catalogue).renderingMode(.template)
                        Text("Tab.catalog")
                    }
                    .backgroundStyle(.background)
                
                CartView(context: CartViewModel(service: serviceAssembly.nftOrderService))
                    .tabItem {
                        Image(.cart).renderingMode(.template)
                        Text("Tab.cart")
                    }
                    .backgroundStyle(.background)
            }
            .navigationDestination(for: RouteEndpoint.self) { endpoint in
                switch endpoint {
                case .payment(let parent):
                    PaymentMethodView(context: PaymentMethodViewModel(service: CurrencyServiceImpl(
                        networkClient: DefaultNetworkClient(),
                        storage: CurrencyStorageImpl())))
                        .environment(parent)
                case .paymentResult:
                    PaymentSuccessView()
                case .agreement(let parent):
                    UserAgreementView()
                        .environment(parent)
                case .collectionNft(let collection, let nfts):
                    CollectionNFTView(vm: CollectionNFTViewModel(collection: collection, nfts: nfts, serviceAssembly: vm.serviceAssembly))
                case .webView(let url):
                    if let webURL = URL(string: url) {
                        WebViewContainer(url: webURL)
                    }
                }
            }
            .task {
                await vm.loadCollections()
                await vm.loadAllNfts()
                await vm.loadOrder()
                await vm.loadUserProfile()
            }
            .onAppear() {
                UITabBar.appearance().unselectedItemTintColor = .ypBlackAD
            }
        }
    }
}

#Preview {
    TabBarView()
}
