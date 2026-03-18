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
                
    func toPayment() {
        endpoint.append(.payment)
    }
    
    func toCart() {
        endpoint.append(.cart)
    }
    
    func toAgreement() {
        endpoint.append(.agreement)
    }
    
    func toRoot() {
        endpoint.removeAll()
    }
}
