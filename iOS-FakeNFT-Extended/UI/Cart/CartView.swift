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
                
                Button {
                    showSortOptions = true
                } label: {
                    Image(.sort)
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
            
            Spacer()
        }
    }
}

#Preview {
    CartView()
}
