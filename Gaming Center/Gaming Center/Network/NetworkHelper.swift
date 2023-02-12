//
//  NetworkHelper.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

class NetworkHelper {
    static let base_url = "https://api.rawg.io/api/games"
    static let api_key = "2bf5a36d9c4c44a981bc00d95d60a445"
}

enum NetworkError: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
    case generalError = "Unknown Error"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Query: String {
    case search = "?search="
    case page = "?page="
    case pageSize = "&page_size="
    case key = "&key="
    case utm = "?utm_source="
}
