import SwiftUI

struct TabBarView: View {
    @State var vm = CatalogueViewModel(
        ServiceAssembly: ServicesAssembly(networkClient: DefaultNetworkClient())
    )
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
            
            CatalogueView(vm: vm)
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        image: .catalogue
                    )
                }
            
        }
        .task {
            await vm.loadCollections()
            await vm.loadAllNfts()
            await vm.loadOrder()
        }
    }
}
