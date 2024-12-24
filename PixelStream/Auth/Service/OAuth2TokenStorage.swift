//
//  OAuth2TokenStorage.swift
//  PixelStream
//
//  Created by Liz-Mary on 20.12.2024.
//
import Foundation

struct OAuthTokenResponse: Decodable {
    let token: String

    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}

final class OAuth2TokenStorage {
    private let tokenKey = "Token" // Ключ для хранения токена в UserDefaults
    
    // Токен авторизации
    var token: String? {
        get {
            // Получение токена из UserDefaults
            UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            // Сохранение токена в UserDefaults
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}
