//
//  NftCardItemCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 17.03.2026.
//

import SwiftUI

struct NftCardItemCell: View {
    @State private var showFullScreenCover = false
    var item: NftCardItem
    
    var body: some View {
        HStack(spacing: 0) {
            imageView
            detailsView
            Spacer()
            deleteView
        }
        .frame(height: 108)
    }
        
    private var imageView: some View {
        Image(item.image)
            .resizable()
            .scaledToFit()
            .frame(width: 108, height: 108)
    }
    
    private var detailsView: some View {
        VStack {
            Text(item.name)
                .font(.bodyBold17)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(item.ratingImage)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("NftCardItemCell.details.price")
                .font(.bodyRegular13)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(item.price.description)
                Text(String(describing: item.currency))
            }
            .font(.bodyBold17)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 120, height: 92)
        .padding(.leading, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    private var deleteView: some View {
        Button {
            showFullScreenCover.toggle()
            print("delete fired")
        } label: {
            Image(.cartDelete).renderingMode(.template)
        }
        .buttonStyle(.plain)
        .fullScreenCover(isPresented: $showFullScreenCover) {
            VStack {
                Image(.deleteStub)
                Text("NftCardItemCell.delete.title")
                HStack {
                    Button {
                    } label: {
                        Text("NftCardItemCell.delete.action")
                    }
                    
                    Button {
                        showFullScreenCover.toggle()
                    } label: {
                        Text("NftCardItemCell.delete.cancel")
                    }
                }
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .center
                )
            .background(BackgroundBlurView())
        }
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


#Preview {
    NftCardItemCell(item: NftCardItem.mockItems[0])
}
