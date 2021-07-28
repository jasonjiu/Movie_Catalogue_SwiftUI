//
//  VideoView.swift
//  Movie Catalogue SwiftUI
//
//  Created by Jason Prosia on 28/07/21.
//  Copyright © 2021 Jason Dicoding IOS. All rights reserved.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
        
    }
}
