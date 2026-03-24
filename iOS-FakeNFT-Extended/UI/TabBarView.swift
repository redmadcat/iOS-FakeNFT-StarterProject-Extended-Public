import SwiftUI

struct TabBarView: View {
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
                case .payment:
                    PaymentMethodView(context: PaymentMethodViewModel(service: CurrencyServiceImpl(
                        networkClient: DefaultNetworkClient(),
                        storage: CurrencyStorageImpl())))
                case .cart:
                    Text("Cart")
                case .agreement:
                    UserAgreementView()
                }
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
