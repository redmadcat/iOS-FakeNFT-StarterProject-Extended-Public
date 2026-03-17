//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 13.03.2026.
//

import SwiftUI

struct CartView: View {
    @State private var showSortOptions = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                sortButton
            }
            
            nftCardList
            Spacer()
        }
        .background(.ypWhiteAD)
    }
    
    private var sortButton: some View {
        Button {
            showSortOptions = true
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
        List(NftCardItem.mockItems) { item in
            NftCardItemCell(item: item)
                .listRowBackground(Color.ypWhiteAD)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: 16,
                        leading: 0,
                        bottom: 16,
                        trailing: 0
                    )
                )
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(0)
    }
}

#Preview {
    CartView()
}
