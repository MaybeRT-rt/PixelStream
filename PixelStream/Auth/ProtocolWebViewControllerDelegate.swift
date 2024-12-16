//
//  ProtocolWebViewControllerDelegate.swift
//  PixelStream
//
//  Created by Liz-Mary on 16.12.2024.
//

protocol WebViewControllerDelegate: AnyObject {
    func webViewController(_ vc: WebViewController, didAuthenticateWithCode code: String)
    func webViewControllerDidCancel(_ vc: WebViewController)
}
