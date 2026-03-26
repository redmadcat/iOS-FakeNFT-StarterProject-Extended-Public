//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 11.03.2026.
//

import SwiftUI

struct CatalogueView: View {
     let vm : CatalogueViewModel
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
                            ForEach(vm.collections) { collection in
                                
                                Button{
                                    let nfts =  vm.mapNftsToCollection(collection: collection)
                                    path.append(.collectionNft(collection, nfts))
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

            
            .navigationDestination(for: SelectionType.self) { type in
                switch type {
                case .collectionNft(let collection, let nfts):
                    CollectionNFTView(vm: CollectionNFTViewModel(collection: collection, nfts: nfts),path: $path
                    )
                case .webView(let url):
                    if let webURL = URL(string: url) {
                        WebViewContainer(url: webURL, path: $path)
                    }
                   
                }
            }
            
        }
    }
}


#Preview {
    let collectionsService = CollectionsServiceImpl(
        networkClient: DefaultNetworkClient(), storage: CollectionsStorageImpl()
    )
    let allNftService = AllNftServiceImpl(networkClient: DefaultNetworkClient(), storage: AllNftStorageImpl())
    
   let vm = CatalogueViewModel(collectionsService: collectionsService, allNftsService: allNftService)
    CatalogueView(vm: vm)
}
