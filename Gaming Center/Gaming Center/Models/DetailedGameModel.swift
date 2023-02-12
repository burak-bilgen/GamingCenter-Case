//
//  DetailedGameModel.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

struct DetailedGame: Codable {
    let id: Int
    let name: String
    let description: String
    let background_image: String
    let website: String
    let reddit_url: String
}
