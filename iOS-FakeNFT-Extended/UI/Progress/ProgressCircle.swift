//
//  ProgressCircle.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI

struct ProgressCircle: View {
    var status: Bool = false
    
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
            .frame(width: 82, height: 82)
            .background(Color.ypLightGreyAD)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(status ? 1 : 0)
    }
}

#Preview {
    ProgressCircle()
}
