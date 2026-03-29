//
//  TestView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Сергей Лебедь on 25.03.2026.
//

import SwiftUI

struct TestView: View {
let servise = NftServiceImpl(networkClient: DefaultNetworkClient(), storage: NftStorageImpl())
    var body: some View {
        Text("Тест запроса…")
            .task {
                 await servise.testLoadNft(id: "d6a02bd1-1255-46cd-815b-656174c1d9c0")
               
            }
    }
    
}

#Preview {
    TestView()
}
