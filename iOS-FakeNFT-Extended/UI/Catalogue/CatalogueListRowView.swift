//
//  CatalogueListRowView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 10.03.2026.
//

import SwiftUI
import Kingfisher

struct CatalogueListRowView: View {
    let imageURL: String
    let title: String
    let imageCount: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            KFImageView(imageURL: imageURL)
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 140, alignment: .top)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("\(title) (\(imageCount))")
                .font(.system(size: 17, weight: .bold))
        }
        .padding(.bottom, 13)
    }
}

#Preview {
    let imageURL: String = "https://avatars.mds.yandex.net/i?id=34f57633c955c47b56c68537076e5bfa570e512b-5905145-images-thumbs&n=13"
    let title: String = "Peach"
    let  imageCount = 11
    CatalogueListRowView(imageURL: imageURL, title: title, imageCount: imageCount)
}
