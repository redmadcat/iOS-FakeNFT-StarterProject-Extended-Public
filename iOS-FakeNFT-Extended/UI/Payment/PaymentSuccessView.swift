//
//  PaymentSuccessView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 25.03.2026.
//

import SwiftUI

struct PaymentSuccessView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(.paymentSuccess)
            Text("PaymentSuccessView.body.title")
                .font(.extraLargeBold)
                .foregroundStyle(.ypBlackAD)
                .frame(maxWidth: 303, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.top, 16)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("PaymentSuccessView.to.cart")
                    .font(.largeBold)
                    .foregroundStyle(.ypWhiteAD)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(.ypBlackAD)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.bottom, 50)
            .padding([.leading, .trailing], 20)
        }
        .ignoresSafeArea(.all)
        .background(.ypWhiteAD)
    }
}

#Preview {
    PaymentSuccessView()
}
