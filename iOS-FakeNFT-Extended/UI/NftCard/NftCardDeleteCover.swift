//
//  NftCardDeleteCover.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI

struct NftCardDeleteCover: View {
    @Binding var showDeleteCover: Bool
    var onDelete: () -> Void
    
    var body: some View {
        VStack {
            Image(.deleteStub)

            Text("NftCardItemCell.delete.title")
                .multilineTextAlignment(.center)
                .font(.bodyRegular13)
                .frame(width: 180)
                .padding(.top, 12)
            HStack {
                Button {
                    onDelete()
                    showDeleteCover.toggle()
                } label: {
                    Text("NftCardItemCell.delete.accept")
                        .font(.bodyRegular17)
                        .foregroundStyle(.ypRed)
                }
                .frame(width: 127, height: 44)
                .background(.ypBlackAD)
                .buttonStyle(.plain)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Button {
                    showDeleteCover.toggle()
                } label: {
                    Text("NftCardItemCell.delete.cancel")
                        .font(.bodyRegular17)
                        .foregroundStyle(.ypWhiteAD)
                }
                .frame(width: 127, height: 44)
                .background(.ypBlackAD)
                .buttonStyle(.plain)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .padding(.top, 20)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
        .background(BackgroundBlurView())
        .ignoresSafeArea()
    }
}

#Preview {
    NftCardDeleteCover(showDeleteCover: .constant(false), onDelete: { })
}
