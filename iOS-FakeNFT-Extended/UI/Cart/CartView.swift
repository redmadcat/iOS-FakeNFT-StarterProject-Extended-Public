//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 13.03.2026.
//

import SwiftUI

struct CartView: View {
    @State private var showSortOptions = false
    @State private var nftCards: [NftCardItem] = NftCardItem.mockItems
    private var currencyStub: String {
        nftCards.isEmpty ? "" :  String(describing: nftCards[0].currency)
    }
    
    var body: some View {
        VStack {
            if nftCards.isEmpty {
                CartEmptyView()
            } else {
                HStack {
                    Spacer()
                    sortButton
                }
                nftCardList
                totalPayment
            }
        }
        .background(.ypWhiteAD)
    }
    
    private var sortButton: some View {
        Button {
            showSortOptions.toggle()
        } label: {
            Image(.sort).renderingMode(.template)
        }
        .padding(.trailing, 10)
        .frame(width: 42, height: 42)
        .buttonStyle(.plain)
        .confirmationDialog("ActionSheet.sorting.title", isPresented: $showSortOptions, titleVisibility: .visible) {
            Button("ActionSheet.sorting.price") {
                
            }
            Button("ActionSheet.sorting.rating") {
                
            }
            Button("ActionSheet.sorting.name") {
                
            }            
            Button("ActionSheet.sorting.close", role: .cancel) {
                            
            }
        }
    }
    
    private var nftCardList: some View {
        List(nftCards) { item in
            NftCardItemCell(item: item, onDelete: { result in
                if let index = nftCards.firstIndex(of: result) {
                    nftCards.remove(at: index)
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
    
    private var totalPayment: some View {
        HStack {
            VStack {
                Text(verbatim: nftCards.count.description + " NFT")
                    .font(.bodyRegular15)
                    .foregroundStyle(.ypBlackAD)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(verbatim: nftCards.reduce(0) { $0 + $1.price }.description + " " + currencyStub)
                    .font(.bodyBold17)
                    .foregroundStyle(.ypGreen)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            
            Button {
                
            } label: {
                Text("CartView.total.payment")
                    .font(.bodyBold17)
                    .foregroundStyle(.ypWhiteAD)
            }
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
}

#Preview {
    CartView()
}
