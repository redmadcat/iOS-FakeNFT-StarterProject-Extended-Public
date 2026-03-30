//
//  Coordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 27.03.2026.
//

import WebKit

final class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    
    init(_ parent: WebView) {
        self.parent = parent
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parent.isLoading = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        parent.isLoading = false
    }
}
