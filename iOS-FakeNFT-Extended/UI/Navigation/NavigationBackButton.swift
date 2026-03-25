//
//  NavigationBackButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 23.03.2026.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            if let action { action() }
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.ypBlackAD)
        }
    }
}

#Preview {
    NavigationBackButton()
}
