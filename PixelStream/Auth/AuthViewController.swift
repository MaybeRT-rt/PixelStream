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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    @IBAction func loginInTapped(_ sender: Any) {
    }
}
