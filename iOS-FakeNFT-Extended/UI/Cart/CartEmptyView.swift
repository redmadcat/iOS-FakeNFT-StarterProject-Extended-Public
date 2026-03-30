//
//  CartEmptyView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI

struct CartEmptyView: View {
    var body: some View {
        VStack {
            Text("CartEmptyView.title")
                .font(.largeBold)
                .foregroundStyle(.ypBlackAD)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
        .background(.ypWhiteAD)
    }
}

#Preview {
    CartEmptyView()
}
