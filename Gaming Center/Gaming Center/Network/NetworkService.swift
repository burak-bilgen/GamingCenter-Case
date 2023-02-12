//
//  NetworkService.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

class NetworkService {
    static func request<T: Codable>(type: T.Type, address: String, method: HTTPMethod, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        let session = URLSession.shared

        guard let url = URL(string: address) else { return completionHandler(.failure(.invalidURL)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if error != nil { completionHandler(.failure(.generalError)) }
            
            guard let data else { return completionHandler(.failure(.invalidURL)) }
            self.handleResponse(data: data) { response in
                completionHandler(response)
            }
        }
        
        dataTask.resume()
    }
    
    static func handleResponse<T: Codable>(data: Data, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(result))
        } catch {
            completionHandler(.failure(.invalidData))
        }
    }
}
