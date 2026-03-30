//
//  NftCardItemCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI
import Kingfisher

struct NftCardItemCell: View {
    @State private var showDeleteCover = false
    var nft: Nft
    var onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            nftCardImage
            nftDetails
            Spacer()
            deleteView
        }
        .frame(height: 108)
    }
        
    private var nftCardImage: some View {
        NftCardImage(imageUrl: nft.images.first)
    }
    
    private var nftDetails: some View {
        VStack {
            Text(nft.name)
                .font(.largeBold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(ratingImage(rating: nft.rating))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("NftCardItemCell.details.price")
                .font(.smallRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(nft.price.description)
                Text("ETH")
            }
            .font(.largeBold)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 120, height: 92)
        .padding(.leading, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    private var deleteView: some View {
        Button {
            showDeleteCover.toggle()
        } label: {
            Image(.cartDelete).renderingMode(.template)
        }
        .buttonStyle(.plain)
        .fullScreenCover(isPresented: $showDeleteCover) {
            NftCardDeleteCover(showDeleteCover: $showDeleteCover,
                               onDelete: onDelete,
                               imageUrl: nft.images.first)
        }
    }
    
    private func ratingImage(rating: Int) -> String {
        switch rating {
        case 1: return "Rating1"
        case 2: return "Rating2"
        case 3: return "Rating3"
        case 4: return "Rating4"
        case 5: return "Rating5"
        default:
            return "Rating0"
        }
    }
}
