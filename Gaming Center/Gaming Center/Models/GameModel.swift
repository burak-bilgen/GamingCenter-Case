//
//  GameModel.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

struct Game: Codable {
    let id: Int?
    let name: String?
    let metacritic: Int?
    let background_image: String?
    let genres: [Genre]?
}
