//
//  WebViewContainer.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 26.03.2026.
//

import SwiftUI

struct WebViewContainer: View {
    let url: URL
    @Binding var path: [SelectionType]

    var body: some View {
        VStack(spacing: 0) {
            Button {
                path.removeLast()
                
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .frame(height: 42)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
          
            WebView(url: url)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}
