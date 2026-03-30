import SwiftUI

struct TabBarView: View {
    @State var vm = CatalogueViewModel(
        serviceAssembly: ServicesAssembly(networkClient: DefaultNetworkClient())
    )

    @State private var router = Router.shared    
    
    var body: some View {
        NavigationStack(path: $router.endpoint) {
            TabView {
                TestCatalogView()
                    .tabItem {
                        Label(
                            NSLocalizedString("Tab.catalog", comment: ""),
                            systemImage: "square.stack.3d.up.fill"
                        )
                    }
                    .backgroundStyle(.background)
                
                CatalogueView(vm: vm)
                    .tabItem {
                        Label(
                            NSLocalizedString("Tab.catalog", comment: ""),
                            image: .catalogue
                        )
                    }
                
                CartView(context: CartViewModel(service: NftOrderServiceImpl(
                    networkClient: DefaultNetworkClient(),
                    storage: NftOrderStorageImpl())))
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
