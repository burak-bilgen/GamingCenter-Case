//
//  GameListCell.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import UIKit
import SDWebImage

protocol GameItemProtocol {
    var titleText: String { get }
    var imageData: String { get }
    var scoreText: String { get }
    var genreText: String { get }
}

class GameListCell: UITableViewCell {

    @IBOutlet weak var gameGenreValueLabel: UILabel!
    
    @IBOutlet weak var gameScoreValueLabel: UILabel!
    @IBOutlet weak var gameScoreTitleLabel: UILabel!
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with data: GameItemProtocol) {
        data.titleText.put(to: gameTitleLabel)
        data.genreText.put(to: gameGenreValueLabel)
        
        data.scoreText.put(to: gameScoreValueLabel)
        
        Headlines.metacritic.put(to: gameScoreTitleLabel)
        
        if let imgURL = URL(string: data.imageData) {
            gameImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            gameImageView.sd_setImage(with: imgURL)
        }
    }
}
