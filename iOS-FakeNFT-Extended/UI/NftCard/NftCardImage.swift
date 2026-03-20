//
//  NftCardImage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 20.03.2026.
//

import SwiftUI
import Kingfisher

struct NftCardImage: View {
    var imageUrl: URL?
    
    var body: some View {
        KFImage(imageUrl)
            .resizable()
            .scaledToFit()
            .frame(width: 108, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NftCardImage()
}
