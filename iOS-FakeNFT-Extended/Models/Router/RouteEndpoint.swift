//
//  RouteEndpoint.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 18.03.2026.
//

enum RouteEndpoint: Hashable {
    case payment(parent: CartViewModel)
    case paymentResult
    case agreement(parent: PaymentMethodViewModel)
    case collectionNft(CollectionModel, [NFTCellModel])
    case webView(url: String)
}
