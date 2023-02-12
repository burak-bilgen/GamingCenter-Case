//
//  GameDataManager.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

class GameListManager {
    static func fetchGameList(with query: String?, page: Int = 1, pageSize: Int = 10, completionHandler: @escaping ((GameList?, String?) -> Void)) {
        
        var address = NetworkHelper.base_url

        if let query { address.append(Query.search.rawValue + query) }
        address.append(Query.page.rawValue + String(page))
        address.append(Query.pageSize.rawValue + String(pageSize))

        NetworkService.request(type: GameList.self, address: address, method: .get) { response in
            switch response {
            case .success(let items):
                completionHandler(items, nil)
            case .failure(let error):
                completionHandler(nil, error.rawValue)
            }
        }
    }
}
