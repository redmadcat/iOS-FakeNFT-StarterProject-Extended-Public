//
//  UserAgreementView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Roman Yaschenkov on 24.03.2026.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") {
                    WebView(url: url, isLoading: $isLoading)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
            
            ProgressCircle(status: isLoading)
        }
        .navigationTitle("UserAgreementView.navigation.title")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton()
            }
        }
        .background(.ypWhiteAD)
    }
}

private struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
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
}

#Preview {
    UserAgreementView()
}
