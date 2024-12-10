//
//  ProfileViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 25.11.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    private var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .left
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Avatar")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterena_nov"
        label.textColor = .ypGray
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Exit"), for: .normal)
        return button
    }()
    
    private lazy var stackViewAvatarAndLogout: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImage, logoutButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewAvatarAndLogout, nameLabel, loginLabel, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        logoutButton.addTarget(self, action: #selector (logoutButtonTapped), for: .touchUpInside)
        
        view.addSubview(allStackView)
        
        NSLayoutConstraint.activate([
            allStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            allStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            allStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            stackViewAvatarAndLogout.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.leadingAnchor.constraint(equalTo: stackViewAvatarAndLogout.leadingAnchor),
            
            logoutButton.trailingAnchor.constraint(equalTo: stackViewAvatarAndLogout.trailingAnchor, constant: -24),
            logoutButton.widthAnchor.constraint(equalToConstant: 24),
            logoutButton.heightAnchor.constraint(equalToConstant: 24)
            
        ])
    }
    
    // MARK: - Actions
    @objc private func logoutButtonTapped() {
        print("logout")
    }
}
