//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 11.03.2026.
//

import SwiftUI

struct CatalogueView: View {
    var vm : CatalogueViewModel
    @State private var showSort = false
    @State private var path: [SelectionType] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        showSort = true
                    }, label: {
                        Image(.sortIcon)
                    })
                    .frame(width: 42, height: 42)
                }
                .frame(height: 42)
                ZStack{
                    if vm.collections.isEmpty {
                        ProgressView()
                    }
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 8) {
                            ForEach(vm.collections, id: \.id) { collection in
                                
                                Button{
                                    path.append(.collectionNft(collection))
                                }label:{
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
                        
                    }
                }
            }
            .padding()
            .confirmationDialog(
                "Сортировка",
                isPresented: $showSort,
                titleVisibility: .visible
            ) {
                Button("По названию") {
                    Task {
                        await vm.sortByName()
                    }
                }
                
                Button("По количеству NFT") {
                    Task {
                        await vm.sortByCount()
                    }
                }
                
                Button("Закрыть", role: .cancel) { }
            }
            .task {
                await vm.loadCollections()
            }
            
            
            .navigationDestination(for: SelectionType.self) { type in
                switch type {
                case .collectionNft(let collection):
                    CollectionNFTView(vm: CollectionNFTViewModel(collection: collection)
                    )
                   
                }
            }
            
        }
    }
}


#Preview {
    let service = CollectionsServiceImpl(
        networkClient: DefaultNetworkClient()
    )
    let vm = CatalogueViewModel(collectionsService: service)
    CatalogueView(vm: vm)
}
