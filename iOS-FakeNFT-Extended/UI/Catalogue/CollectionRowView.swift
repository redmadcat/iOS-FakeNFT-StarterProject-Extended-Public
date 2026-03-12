//
//  CollectionRowView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 12.03.2026.
//

import SwiftUI
import Kingfisher

struct CollectionRowView: View {
    @Binding var isLike: Bool
    @Binding var isSelected: Bool
    let rating: Int
    let imageURL: String
    let name: String
    let price: String
    let actionLike: () -> Void
    let actionSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            imageView
            ratingView
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.system(size: 17, weight: .bold))
                    
                    Text("\(price) ETH")
                        .font(.system(size: 10, weight: .medium))
                }
                Spacer()
                selectButton
            }
        }
        .frame(width: 108, height: 172)
    }
    
    var imageView: some View {
        KFImage(URL(string: imageURL))
            .placeholder { ProgressView() }
            .fade(duration: 0.25)
            .resizable()
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
                if i <= rating {
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
    let rating: Int = 4
    let imageURL: String = "https://avatars.mds.yandex.net/i?id=34f57633c955c47b56c68537076e5bfa570e512b-5905145-images-thumbs&n=13"
    let name: String = "Ruby"
    let price: String = "1"
    
    CollectionRowView(isLike: $isLike, isSelected: $isSelected, rating: rating, imageURL: imageURL, name: name, price: price, actionLike: {isLike = !isLike}, actionSelect: {isSelected = !isSelected})
}
