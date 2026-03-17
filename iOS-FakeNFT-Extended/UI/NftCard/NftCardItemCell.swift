//
//  NftCardItemCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI

struct NftCardItemCell: View {
    @State private var showDeleteCover = false
    var item: NftCardItem
    var onDelete: ((NftCardItem) -> Void)
    
    var body: some View {
        HStack(spacing: 0) {
            imageView
            detailsView
            Spacer()
            deleteView
        }
        .frame(height: 108)
    }
        
    private var imageView: some View {
        Image(item.image)
            .resizable()
            .scaledToFit()
            .frame(width: 108, height: 108)
    }
    
    private var detailsView: some View {
        VStack {
            Text(item.name)
                .font(.bodyBold17)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(item.ratingImage)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("NftCardItemCell.details.price")
                .font(.bodyRegular13)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(item.price.description)
                Text(String(describing: item.currency))
            }
            .font(.bodyBold17)
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
            NftCardDeleteCover(showDeleteCover: $showDeleteCover, onDelete: {
                onDelete(item)
            })
        }
    }
}

#Preview {
    NftCardItemCell(item: NftCardItem.mockItems[0], onDelete: { _ in })
}
