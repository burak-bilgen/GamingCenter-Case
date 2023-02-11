//
//  GameListCell.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import UIKit

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
    
    func configureCell(with data: String?) {
        guard let data else { return }
        
//        data.image.put(to: gameImageView)
        
        data.put(to: gameTitleLabel)
        data.put(to: gameScoreTitleLabel)
        data.put(to: gameScoreValueLabel)
        data.put(to: gameGenreValueLabel)
    }
}
