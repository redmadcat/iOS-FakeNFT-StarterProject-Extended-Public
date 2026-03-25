//
//  PaymentMethodView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI

struct PaymentMethodView: View {
    @Environment(CartViewModel.self) private var parent
    @State private var showAlert = false
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
                
                paymentSection
            }
            .navigationTitle("PaymentMethodView.navigation.title")
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
            .task {
                await context.load()
            }
                        
            ProgressCircle(status: context.status == .loading)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var paymentSection: some View {
        VStack {
            VStack {
                Text("PaymentMethodView.payment.agreement")
                    .font(.smallRegular)
                    .foregroundStyle(.ypBlackAD)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    Router.shared.toAgreement(parent: context)
                }) {
                    Text("PaymentMethodView.payment.legalInfo")
                        .font(.smallRegular)
                        .foregroundColor(.ypBlue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding([.top, .bottom], -4)
                .buttonStyle(.plain)
            }
            .padding(20)
            
            Button {
                Task {
                    await pay()
                }
            } label: {
                Text("PaymentMethodView.pay")
                    .font(.largeBold)
                    .foregroundStyle(.ypWhiteAD)
            }
            .alert(
                Text("PaymentMethodView.payment.failed"),
                isPresented: $showAlert)
            {
                Button("PaymentMethodView.payment.cancel", role: .cancel) {
                    showAlert = false
                }
                Button("PaymentMethodView.payment.retry") {
                    Task {
                        await pay()
                    }
                }
            }
            .disabled(selectedCurrency == nil)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(.ypBlackAD)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.bottom, 50)
            .padding([.leading, .trailing], 20)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 186,
            alignment: .bottom
        )
        .background(.ypLightGreyAD)
        .clipShape(
            .rect(
                topLeadingRadius: 12,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 12
            )
        )
    }
    
    private func pay() async {
        await parent.pay(currency: selectedCurrency) { failureStatus in
            if failureStatus {
                showAlert = failureStatus
            } else {
                Router.shared.toPaymentResult()
            }
        }
    }
}

#Preview {
    PaymentMethodView(context: PaymentMethodViewModel(service: CurrencyServiceImpl(
            networkClient: DefaultNetworkClient(),
            storage: CurrencyStorageImpl()))
    )
}
