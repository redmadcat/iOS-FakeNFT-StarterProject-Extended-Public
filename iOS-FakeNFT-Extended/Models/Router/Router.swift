//
//  Router.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 18.03.2026.
//

import SwiftUI

@MainActor
@Observable
final class Router {
    static let shared = Router()
    
    var endpoint: [RouteEndpoint] = []
                
    func toPayment(parent: CartViewModel) {
        endpoint.append(.payment(parent: parent))
    }
    
    func toPaymentResult() {
        endpoint.append(.paymentResult)
    }
    
    func toAgreement(parent: PaymentMethodViewModel) {
        endpoint.append(.agreement(parent: parent))
    }
    
    func toCollection(collection: CollectionModel, nfts: [NFTCellModel]) {
        endpoint.append(.collectionNft(collection, nfts))
    }
    
    func toWebView(url: String) {
        endpoint.append(.webView(url: url))
    }
    
    func toRoot() {
        endpoint.removeAll()
    }
}
