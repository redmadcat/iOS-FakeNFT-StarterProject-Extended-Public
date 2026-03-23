//
//  PaymentMethodView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI

struct PaymentMethodView: View {
    
    private static let columns = [
        GridItem(.flexible(), spacing: 7),
        GridItem(.flexible(), spacing: 7)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: Self.columns, spacing: 7) {
                    
                }
            }
        }
        .navigationTitle("PaymentMethodView.navigation.title")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton()
            }
        }
        .background(.ypWhiteAD)
        .task {

        }
    }
}

#Preview {
    PaymentMethodView()
}
