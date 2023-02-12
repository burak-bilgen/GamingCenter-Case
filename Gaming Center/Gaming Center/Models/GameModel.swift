//
//  GameModel.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

struct Game: Codable, GameItemProtocol {
    let id: Int?
    let name: String?
    let metacritic: Int?
    let background_image: String?
    let genres: [Genre]?
    
    var titleText: String {
        name ?? String()
    }
    
    var imageData: String {
        background_image ?? String()
    }
    
    var scoreText: String {
        guard let metacritic else { return String() }
        return String(describing: metacritic)
    }
    
    var genreText: String {
        guard let genres else { return String() }
        
        var genre: [String] = []
        
        genres.forEach {
            if let name = $0.name {
                genre.append(name)
            }
        }
        
        return genre.joined(separator: ", ")
    }
}
