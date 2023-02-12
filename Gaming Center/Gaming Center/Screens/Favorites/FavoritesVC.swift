//
//  FavoritesVC.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var gameVisitWebsiteButton: UIButton!
    @IBOutlet weak var gameVisitRedditButton: UIButton!
    
    @IBOutlet weak var gameButtonStackView: UIStackView!
    @IBOutlet weak var gameButtonBaseView: UIView!
    
    @IBOutlet weak var gameDescriptionValueLabel: UILabel!
    @IBOutlet weak var gameDescriptionTitleLabel: UILabel!
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    @IBOutlet weak var gameImageShadowView: UIImageView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameImageBaseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configure(with data: String?) {
        guard let data else { return }

        data.put(to: gameDescriptionValueLabel)
        data.put(to: gameDescriptionTitleLabel)
        
        data.put(to: gameTitleLabel)
        
//        data.image.put(to: gameImageView)
    }
    
    @IBAction func visitReddit(_ sender: UIButton) {
        
    }
    
    @IBAction func visitWebsite(_ sender: UIButton) {
        
    }
}
