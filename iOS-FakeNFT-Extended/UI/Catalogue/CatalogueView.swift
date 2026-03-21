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

    var body: some View {
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
                                
                            }label:{
                                CatalogueListRowView(
                                    imageURL: collection.cover,
                                    title: collection.name,
                                    imageCount: collection.nfts.count
                                )
                            }
                            .buttonStyle(.plain)
                            .onAppear {
                                if collection.id == vm.collections.last?.id {
                                    Task {
                                       await vm.loadCollections()
                                    }
                                }
                            }
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
                    await vm.loadSortByName()
                           }
            }
            
            Button("По количеству NFT") {
                Task {
               await vm.loadSortByCount()
                      }
            }
            
            Button("Закрыть", role: .cancel) { }
        }
        .task {
            await vm.loadCollections()
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
