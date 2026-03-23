//
//  KFImageView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 17.03.2026.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    let imageURL: String
    var body: some View {
        KFImage(URL(string: imageURL))
            .placeholder { ProgressView() }
            .fade(duration: 0.25)
            .resizable()
    }
}

#Preview {
    let imageURL = "https://avatars.mds.yandex.net/i?id=9b49fc41c169d5c20a3e71d5cae1934ab2f2710e-4182781-images-thumbs&n=13"
    KFImageView(imageURL: imageURL)
}
