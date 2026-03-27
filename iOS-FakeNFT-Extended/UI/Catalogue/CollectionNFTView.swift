//
//  CollectionNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 18.03.2026.
//

import SwiftUI

struct CollectionNFTView: View {
    @Environment(\.dismiss) private var dismiss
    @State var vm: CollectionNFTViewModel
    @Binding var path: [SelectionType]
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    titleImage
                    nameCollection
                    author
                    description
                    collection
                }
            }
            .ignoresSafeArea()
            Button {
               path.removeAll()
                
            } label: {
                HStack {
                    
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .frame(height: 42)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
        }
    }
    
    var titleImage: some View {
        KFImageView(imageURL: vm.collection.cover)
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 310, alignment: .top)
            .clipped()
            .clipShape(
                .rect(
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 12
                )
            )
            .padding(.bottom, 16)
    }
    
    var nameCollection: some View {
        Text(vm.collection.name)
            .font(.system(size: 22, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 28)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
    }
    
        var author: some View {
            HStack {
                Text("Collection.author:")
                    .font(.system(size: 13, weight: .regular))
                    .frame(width: 112, alignment: .leading)
            Button {
                path.append(.webView(url:vm.collection.website))
      
                
            } label: {
                    Text("\(vm.collection.author)")
                        .foregroundColor(.blue)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 20)
               
            }
            .padding(.horizontal, 16)
        }
    
    
    var description: some View {
        Text(vm.collection.description)
            .font(.system(size: 13, weight: .regular))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }
    var collection: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        return  LazyVGrid(columns: columns, spacing: 8) {
            ForEach(vm.nfts) { nft in
                CollectionRowView( isLike: vm.likedNFTIds.contains(nft),
                                   isSelected: vm.selectedIds.contains(nft.id),
                                   nftCell: nft,
                                   actionLike: {
                    vm.toggleLike(for: nft)
                },
                                   actionSelect: {
                    Task {
                           await vm.selectNft(nft)
                       }
                }
                )
            }
        }
        .padding(.horizontal, 10 )
        .padding(.top, 24)
        .navigationBarBackButtonHidden(true)
        .task {
            await vm.loadSelected()
        }
    }
    
}

#Preview {
 
    @Previewable  @State var path: [SelectionType] = [.collectionNft( CollectionModel.mock[0], NFTCellModel.mock)]
    let vm = CollectionNFTViewModel(collection: CollectionModel.mock[0], nfts: NFTCellModel.mock, nflOrderService: NftOrderServiceImpl(networkClient: DefaultNetworkClient(), storage: NftOrderStorageImpl()))
   
    CollectionNFTView(vm: vm, path: $path)
}
