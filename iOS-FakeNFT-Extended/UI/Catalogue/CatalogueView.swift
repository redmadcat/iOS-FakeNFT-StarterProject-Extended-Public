//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 11.03.2026.
//

import SwiftUI

struct CatalogueView: View {
    @State private var showSort = false
    let vm : CatalogueViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showSort = true
                }, label: {
                    Image(.sort)
                })
                .disabled(vm.collections.isEmpty)
                .padding(.trailing, 10)
                .frame(width: 42, height: 42)
                .buttonStyle(.plain)
            }
            ZStack {
                if vm.collections.isEmpty {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 8) {
                        ForEach(vm.collections) { collection in
                            Button{
                                let nfts =  vm.mapNftsToCollection(collection: collection)
                                Router.shared.toCollection(collection: collection, nfts: nfts)
                            }label: {
                                CatalogueListRowView(
                                    imageURL: collection.cover,
                                    title: collection.name,
                                    imageCount: collection.nfts.count
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                }
            }
        }
        .confirmationDialog(
            "ActionSheet.sorting.title",
            isPresented: $showSort,
            titleVisibility: .visible
        ) {
            Button("ActionSheet.sorting.name") {
                Task {
                    await vm.sortByName()
                }
            }
            
            Button("ActionSheet.sorting.count") {
                Task {
                    await vm.sortByCount()
                }
            }
            
            Button("ActionSheet.sorting.close", role: .cancel) { }
        }
    }
}


#Preview {
    let vm = CatalogueViewModel(
    serviceAssembly: ServicesAssembly(networkClient: DefaultNetworkClient()))
    CatalogueView(vm: vm)
}
