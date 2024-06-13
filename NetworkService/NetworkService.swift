//
//  NetworkService.swift
//  ShiftFinalProject
//
//  Created by Александр Федоткин on 13.06.2024.
//

import Foundation

enum NetworkService {
    case signIn(token: String)

    private var urlSession: URLSession {
        let config = URLSessionConfiguration.default
        //config.httpAdditionalHeaders = ["Accept": "application/json", "X-GitHub-Api-Version": "2022-11-28"]
        return URLSession(configuration: config)
    }
}

extension NetworkService {
    private func makeRequest() -> URLRequest? {
        switch self {
        case .signIn(let token):
            let baseComponent = URLComponents(string: "https://api.github.com/user")
            guard let baseComponentURL = baseComponent?.url else {
                fatalError() //TODO: MAKE ALERT
            }

            var request = URLRequest(url: baseComponentURL)
            request.httpMethod = "GET"

             request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            return request
        }
    }

    func fetch(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = makeRequest() else {
            fatalError()
        }

        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse,
                      let data {
                let statusCode = httpResponse.statusCode
                switch statusCode {
                    case 200...299:
                        completion(.success(data))
                    case 300...399:
                        fatalError()
                    case 400...499:
                        fatalError()
                    case 500...599:
                        fatalError()
                    default:
                        break
                }
            }
        }
        task.resume()
    }
}
