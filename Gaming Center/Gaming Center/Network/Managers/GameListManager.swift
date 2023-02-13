//
//  GameListManager.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

class GameListManager {
    static func fetchGameList(with searchText: String?, page: Int, pageSize: Int = 10, completionHandler: @escaping ((GameList?, String?) -> Void)) {
        
        var query = String()

        if let searchText { query.append(Query.search.rawValue + searchText) }
        query.append(Query.page.rawValue + String(page))
        query.append(Query.pageSize.rawValue + String(pageSize))

        NetworkService.request(type: GameList.self, query: query, method: .get) { response in
            switch response {
            case .success(let items):
                completionHandler(items, nil)
            case .failure(let error):
                completionHandler(nil, error.rawValue)
            }
        }
    }
}
