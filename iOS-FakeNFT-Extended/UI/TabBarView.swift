import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
//            TestCatalogView()
//                .tabItem {
//                    Label(
//                        NSLocalizedString("Tab.catalog", comment: ""),
//                        systemImage: "square.stack.3d.up.fill"
//                    )
//                }
//                .backgroundStyle(.background)
            let service = CollectionsServiceImpl(
                networkClient: DefaultNetworkClient()
            )
           @State var vm = CatalogueViewModel(collectionsService: service)
            CatalogueView(vm: vm)
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                         image: .catalogue
                    )
                }
        }
    }
}
