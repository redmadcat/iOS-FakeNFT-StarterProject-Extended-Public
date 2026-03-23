//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 13.03.2026.
//

import SwiftUI

struct CartView: View {
    @State private var showSortOptions = false
    @State private var context: CartViewModel
    
    init(context: CartViewModel) {
        self.context = context
    }
    
    var body: some View {
        ZStack {
            VStack {
                if context.noItems {
                    CartEmptyView()
                } else {
                    nftSortMenu
                    nftCardList
                    nftTotalPay
                }
            }
            .background(.ypWhiteAD)
            .task {
                await context.load()
            }

            progressView
        }
    }
    
    private var nftSortMenu: some View {
        HStack {
            Spacer()
            Button {
                showSortOptions.toggle()
            } label: {
                Image(.sort).renderingMode(.template)
            }
            .disabled(context.actionAvailability)
            .padding(.trailing, 10)
            .frame(width: 42, height: 42)
            .buttonStyle(.plain)
            .confirmationDialog("ActionSheet.sorting.title", isPresented: $showSortOptions, titleVisibility: .visible) {
                Button("ActionSheet.sorting.price") {
                    Task {
                        await context.sort(.price)
                    }
                }
                Button("ActionSheet.sorting.rating") {
                    Task {
                        await context.sort(.rating)
                    }
                }
                Button("ActionSheet.sorting.name") {
                    Task {
                        await context.sort(.name)
                    }
                }
                Button("ActionSheet.sorting.close", role: .cancel, action: {})
            }
        }
    }
    
    private var nftCardList: some View {
        List(context.nfts) { item in
            NftCardItemCell(item: item, onDelete: {
                Task {
                    await context.remove(item: item)
                }
            })
            .listRowBackground(Color.ypWhiteAD)
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(
                    top: 16,
                    leading: 16,
                    bottom: 16,
                    trailing: 16
                )
            )
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(0)
        .listStyle(.plain)
    }
    
    private var nftTotalPay: some View {
        HStack {
            VStack {
                Text(context.totalCount)
                    .font(.mediumRegular)
                    .foregroundStyle(.ypBlackAD)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(context.totalPrice)
                    .font(.largeBold)
                    .foregroundStyle(.ypGreen)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            
            Button {
                Router.shared.toPayment()
            } label: {
                Text("CartView.total.payment")
                    .font(.largeBold)
                    .foregroundStyle(.ypWhiteAD)
            }
            .disabled(context.actionAvailability)
            .frame(width: 240, height: 44)
            .background(.ypBlackAD)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(16)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 76,
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
    
    private var progressView: some View {
        ProgressView()
            .frame(width: 82, height: 82)
            .background(Color.ypLightGreyAD)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(context.status == .loading ? 1 : 0)
    }
}

#Preview {
    CartView(context: CartViewModel(service: NftOrderServiceImpl(
            networkClient: DefaultNetworkClient(),
            storage: NftOrderStorageImpl()))
    )
}
