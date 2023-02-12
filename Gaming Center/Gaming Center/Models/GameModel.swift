//
//  GameModel.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

struct Game {
    var id: Int
    var name: String
    var description: String
    var metacritic: Int
    var background_image: String
    var website: String
    var reddit_url: String
    var genres: [Genre]
}
