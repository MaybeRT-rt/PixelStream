//
//  OAuth2Service.swift
//  PixelStream
//
//  Created by Liz-Mary on 19.12.2024.
//

import Foundation

final class OAuth2Service {

    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://unsplash.com/oauth/token")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Формируем параметры запроса
        let bodyParameters = [
            "client_id": AccessKey,
            "client_secret": SecretKey,
            "redirect_uri": RedirectURI,
            "code": code,
            "grant_type": "authorization_code"
        ]
        
        // Преобразуем параметры в Data
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        
        // Отправляем запрос
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Обрабатываем ответ
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Декодируем JSON ответ в OAuthTokenResponse
                let tokenResponse = try JSONDecoder().decode(OAuthTokenResponse.self, from: data)
                completion(.success(tokenResponse.token)) // Отправляем токен в completion
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

