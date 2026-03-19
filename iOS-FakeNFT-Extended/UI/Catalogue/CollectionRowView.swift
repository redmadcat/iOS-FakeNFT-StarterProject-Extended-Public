//
//  CollectionRowView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 12.03.2026.
//

import SwiftUI
import Kingfisher

struct CollectionRowView: View {
    var isLike: Bool
    var isSelected: Bool
    let nftCell: NFTCellModel
    let actionLike: () -> Void
    let actionSelect: () -> Void
   
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            imageView
            ratingView
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(nftCell.name)
                        .font(.system(size: 17, weight: .bold))
                    
                    Text("\(nftCell.price) ETH")
                        .font(.system(size: 10, weight: .medium))
                }
                Spacer()
                selectButton
            }
        }
        .frame(width: 108, height: 172)
        .padding(.bottom, 20)
    }
    
    var imageView: some View {
        KFImageView(imageURL: nftCell.images[0])
            .scaledToFill()
            .frame(width: 108, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .topTrailing) {
                Button {
                    actionLike()
                } label: {
                    isLike ? Image(.likeActive) : Image(.likeNoActive)
                }
                .frame(width: 44, height: 44)
            }
            .padding(.bottom, 4)
    }
    var ratingView: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { i in
                if i <= nftCell.rating {
                    Image(.starActive)
                    
                } else {
                    Image(.starNoActive)
                }
            }
            Spacer()
        }
        .frame(height: 12)
    }
    
    var selectButton: some View {
        Button(action: actionSelect) {
            isSelected ? Image(.selectActive) : Image(.selectNoActive)
        }
        .frame(width: 40, height: 40)
    }
    
}

#Preview {
    @Previewable @State var isLike: Bool = false
    @Previewable @State var isSelected: Bool = false
   
    CollectionRowView(isLike: isLike, isSelected: isSelected,
                     nftCell: NFTCellModel.mock[0], actionLike: {isLike = !isLike}, actionSelect: {isSelected = !isSelected})
}
