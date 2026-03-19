//
//  CatalogueView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 11.03.2026.
//

import SwiftUI

struct CatalogueView: View {
    @State private var showSort = false
    var collectionList: [CollectionModel] = []
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
                if collectionList.isEmpty {
                    ProgressView()
                }
                ScrollView(showsIndicators: false) {
                    
                    LazyVStack(spacing: 8) {
                        ForEach(collectionList) { collection in
                            Button{
                                
                            }label:{
                                CatalogueListRowView(
                                    imageURL: collection.cover,
                                    title: collection.name,
                                    imageCount: collection.ntfs.count
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
                // сортировка по имени
            }
            
            Button("По количеству NFT") {
                // сортировка по количеству
            }
            
            Button("Закрыть", role: .cancel) { }
        }
    }
    
}


#Preview {
    let collectionList = CollectionModel.mock
    CatalogueView(collectionList: collectionList)
}
