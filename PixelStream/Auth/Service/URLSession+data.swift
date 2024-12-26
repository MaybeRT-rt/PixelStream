//
//  Error.swift
//  PixelStream
//
//  Created by Liz-Mary on 19.12.2024.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)       // Неверный HTTP-статус-код
    case urlRequestError(Error)    // Ошибка URLRequest
    case urlSessionError           // Неизвестная ошибка URLSession
    case decodingError(Error)      // Ошибка декодирования ответа
    case invalidResponse           // Некорректный ответ сервера
}

extension URLSession {
    
    func data(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        let fullfillCompletion: (Result<Data, Error>) -> Void = { result in  
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, let response = response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200 ..< 300 ~= statusCode {
                    fullfillCompletion(.success(data))
                } else {
                    fullfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                fullfillCompletion(.failure(NetworkError.urlRequestError(error)))
            } else {
                fullfillCompletion(.failure(NetworkError.urlSessionError)) 
            }
        })
        
        return task
    }
}
