//
//  AuthViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 13.12.2024.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var authLogo: UIImageView!
    
    weak var delegate: AuthViewControllerDelegate?
    
    static let indificatorSegue = "ShowWebView"
    private var webVC: WebViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureBackButton()
    }
    
    
    
    private func setupUI() {
        
        guard let loginButton = loginButton, let authLogo = authLogo else {
               fatalError("UI elements are not properly connected in the storyboard.")
           }
        
        loginButton.layer.cornerRadius = 16
    
        
        NSLayoutConstraint.activate([
            authLogo.heightAnchor.constraint(equalToConstant: 60),
            authLogo.widthAnchor.constraint(equalToConstant: 60),
            authLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 90),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
    }
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AuthViewController.indificatorSegue {
            guard
                let webViewViewController = segue.destination as? WebViewController
            else { fatalError("Failed to prepare for \(AuthViewController.indificatorSegue)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    @IBAction func loginInTapped(_ sender: Any) {
        
    }
}

extension AuthViewController: WebViewControllerDelegate {
    
    func webViewController(_ vc: WebViewController, didAuthenticateWithCode code: String) {
        OAuth2Service().fetchOAuthToken(code) { result in
            switch result {
            case .success(let token):
                // Сохраняем токен
                OAuth2TokenStorage().token = token
                print("Access token: \(token)")
            case .failure(let error):
                print("Failed to fetch token: \(error)")
            }
        }
    }
    
    func webViewControllerDidCancel(_ vc: WebViewController) {
        dismiss(animated: true)
    }
}
