//
//  Headlines.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import Foundation

enum Headlines {
    static let detail = "Detail"
    static let games = "Games"
    static let favorites = "Favorites"
    
    static let metacritic = "metacritic:"
    
    static let caution = "Caution"
}

enum Collection {
    static let favorited = "Favorited"
    static let notFavorited = "Favorite"
}

enum ViewController {
    static let gamesVC = "GamesViewController"
    static let favoritesVC = "FavoritesViewController"
    static let detailVC = "DetailViewController"
}

enum UserDefaultsKey {
    static let favorites = "FavouriteGames"
}
