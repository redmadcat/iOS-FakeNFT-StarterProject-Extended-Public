//
//  PaymentMethodView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI

struct PaymentMethodView: View {
    @State private var context: PaymentMethodViewModel
    @State private var selectedCurrency: Currency?
    
    init(context: PaymentMethodViewModel) {
        self.context = context
    }
    
    private static let columns = [
        GridItem(.flexible(), spacing: 7),
        GridItem(.flexible(), spacing: 7)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: Self.columns, spacing: 7) {
                        ForEach(context.currencies) { currency in
                            CurrencyItemCell(currency: currency,
                                             isSelected: selectedCurrency == currency)
                                .onTapGesture {
                                    selectedCurrency = currency
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
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
                await context.load()
            }
                        
            ProgressCircle(status: context.status == .loading)
        }
    }
}

#Preview {
    PaymentMethodView(context: PaymentMethodViewModel(service: CurrencyServiceImpl(
            networkClient: DefaultNetworkClient(),
            storage: CurrencyStorageImpl()))
    )
}
