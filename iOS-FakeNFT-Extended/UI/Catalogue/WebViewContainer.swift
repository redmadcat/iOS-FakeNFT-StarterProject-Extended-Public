//
//  WebViewContainer.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 26.03.2026.
//

import SwiftUI

struct WebViewContainer: View {
    @State private var isLoading: Bool = true
    let url: URL

    var body: some View {
        ZStack {
            VStack {
                WebView(url: url, isLoading: $isLoading)
                .edgesIgnoringSafeArea(.bottom)
            }
            
            ProgressCircle(status: isLoading)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton()
            }
        }
    }
}

#Preview {
    WebViewContainer(
        url: URL(string: "https://practicum.yandex.ru")!
    )
}

