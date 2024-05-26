//
//  GIFViewRepresentable.swift
//  WorkoutGenerator
//
//  Created by Sydney A on 5/25/24.
//

import SwiftUI
import UIKit
import WebKit

struct GIFViewRepresentable: UIViewRepresentable {
    var gifName: String
    
    func makeUIView(context: Context) -> WKWebView {
        let gifURL = URL(string: gifName)!
        let webView = WKWebView()
        Task {
            let (data, _) = try await URLSession.shared.data(from: gifURL)
            webView.load(data,mimeType: "image/gif",characterEncodingName: "UTF-8", baseURL: gifURL.deletingLastPathComponent())
        }
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //no op
    }
}
