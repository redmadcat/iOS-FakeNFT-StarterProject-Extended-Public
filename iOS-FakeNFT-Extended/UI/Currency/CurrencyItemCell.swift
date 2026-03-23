//
//  CurrencyItemCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI
import Kingfisher

struct CurrencyItemCell: View {
    var currency: Currency
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            KFImage(currency.image)
                .resizable()
                .scaledToFit()
                .padding(2.25)
                .frame(width: 36, height: 36)
                .background(.ypBlack)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(currency.title)
                    .font(.smallRegular)
                    .lineLimit(1)
                
                Text(currency.name)
                    .font(.smallRegular)
                    .foregroundStyle(.ypGreen)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 12)
        .background(.ypLightGreyAD)
        .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.ypBlackAD : Color.clear, lineWidth: 1)
                )
    }
}

#Preview {
    CurrencyItemCell(
        currency: Currency(
            id: "0",
            name: "SHIB",
            image: URL(fileURLWithPath: ""),
            title: "Shiba_Inu"),
        isSelected: false)
}
