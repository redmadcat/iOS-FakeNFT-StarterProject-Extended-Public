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
    let imageCount: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            KFImage(URL(string: imageURL))
                .placeholder {
                    ProgressView()
                }
                .fade(duration: 0.25)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("\(title) (\(imageCount))")
                .font(.system(size: 17, weight: .bold))
                
        }
    }
}

#Preview {
    let imageURL: String = "https://avatars.mds.yandex.net/i?id=34f57633c955c47b56c68537076e5bfa570e512b-5905145-images-thumbs&n=13"
    let title: String = "Peach"
    let  imageCount: String = "11"
    CatalogueListRowView(imageURL: imageURL, title: title, imageCount: imageCount)
}
