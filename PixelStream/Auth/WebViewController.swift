//
//  WebViewViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 13.12.2024.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: AnyObject {
    func webViewController(_ vc: WebViewController, didAuthenticateWithCode code: String)
    func webViewControllerDidCancel(_ vc: WebViewController)
}

final class WebViewController: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var progressView: UIProgressView!
    
    enum WebViewConstants {
        static let unsplashAuthorizeURLString = "https://unsplash.com/login"
    }
    
    weak var delegate: WebViewControllerDelegate?

    private var observerContext = 0
    private var isProgressObserverAdded = false  // Флаг для отслеживания состояния наблюдателя


    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadAuthView()
        //checkAuthorizationStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addProgressObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeProgressObserver()
    }
    
    deinit {
        removeProgressObserver()
    }

    @IBAction private func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.webViewControllerDidCancel(self)
        removeProgressObserver()
    }
    
    private func loadAuthView() {
        guard var urlComponents = URLComponents(string: WebViewConstants.unsplashAuthorizeURLString) else { return }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: AccessKey),
            URLQueryItem(name: "redirect_uri", value: RedirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: AccessScope)
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        updateProgress()
        webView.load(request)
    }

    private func loadPhotoFeed() {
        guard let url = URL(string: "https://unsplash.com") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        updateProgress()
    }
    
    private func checkAuthorizationStatus() {
        // Проверяем, есть ли сохраненный токен
        if let accessToken = UserDefaults.standard.string(forKey: "Token"), !accessToken.isEmpty {
            // Если токен есть — показываем ленту
            loadPhotoFeed()
        } else {
            // Если токен отсутствует — показываем окно авторизации
            loadAuthView()
        }
    }

    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    
    private func addProgressObserver() {
        guard !isProgressObserverAdded else { return }
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: &observerContext)
        isProgressObserverAdded = true
    }

    private func removeProgressObserver() {
        guard isProgressObserverAdded else { return }
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: &observerContext)
        isProgressObserverAdded = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &observerContext else { return }
        
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = extractCode(from: navigationAction) {
            // Сохраняем полученный код авторизации
         //   UserDefaults.standard.set(code, forKey: "Token")
            delegate?.webViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }

    private func extractCode(from navigationAction: WKNavigationAction) -> String? {
        guard let url = navigationAction.request.url,
              let urlComponents = URLComponents(string: url.absoluteString),
              urlComponents.path == "/oauth/authorize/native",
              let codeItem = urlComponents.queryItems?.first(where: { $0.name == "code" }) else {
            return nil
        }
        
        return codeItem.value
    }
}
