//
//  AuthViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 13.12.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var authLogo: UIImageView!
    
    static let indicator = "ShowWebView"
    private var webVC: WebViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureBackButton()
    }
    
    private func setupUI() {
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
    
    @IBAction func loginInTapped(_ sender: Any) {
    }
}
