//
//  GameDetailManager.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

class GameDetailManager {
    static func fetchGameDetail(with id: Int, completionHandler: @escaping ((DetailedGame?, String?) -> Void)) {
        
        var query = String()

        query.append(Query.slash.rawValue)
        query.append(String(id))

        NetworkService.request(type: DetailedGame.self, query: query, method: .get) { response in
            switch response {
            case .success(let items):
                completionHandler(items, nil)
            case .failure(let error):
                completionHandler(nil, error.rawValue)
            }
        }
    }
}
