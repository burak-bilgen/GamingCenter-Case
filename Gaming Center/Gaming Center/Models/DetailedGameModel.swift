//
//  DetailedGameModel.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

struct DetailedGame: Codable {
    let id: Int?
    let name: String?
    let metacritic: Int?
    let description_raw: String?
    let background_image: String?
    let website: String?
    let reddit_url: String?
    let genres: [Genre]?
}
