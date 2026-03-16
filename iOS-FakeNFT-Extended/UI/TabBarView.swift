import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            TestCatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: "square.stack.3d.up.fill"
                    )
                }
                .backgroundStyle(.background)
            CartView()
                .tabItem {
                    Image(.cart).renderingMode(.template)
                    Text("Tab.cart")
                }
                .backgroundStyle(.background)
        }
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = .ypBlackAD
        }
    }
}
