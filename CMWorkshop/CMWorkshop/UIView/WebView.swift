//
//  WebView.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 29/7/2563 BE.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var request: URLRequest //ตัวแปรเปิด เว็ป
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(self.request)
    }
}
