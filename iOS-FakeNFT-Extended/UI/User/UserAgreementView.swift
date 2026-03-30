//
//  UserAgreementView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 24.03.2026.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    @Environment(PaymentMethodViewModel.self) private var parent
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") {
                    WebView(url: url, isLoading: $isLoading)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
            
            ProgressCircle(status: isLoading)
        }
        .navigationTitle("UserAgreementView.navigation.title")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton() {
                    parent.forceRefresh = false
                }
            }
        }
        .background(.ypWhiteAD)
    }
}

#Preview {
    UserAgreementView()
}
