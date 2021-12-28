// from https://www.youtube.com/watch?v=9fz8EW-dX-I
// and https://github.com/pitt500/GifView-SwiftUI/blob/main/GifView_SwiftUI/GifView_SwiftUI/GifImage.swift

import SwiftUI
import WebKit

struct GifImage: NSViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )

        return webView
    }

    func updateNSView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}
