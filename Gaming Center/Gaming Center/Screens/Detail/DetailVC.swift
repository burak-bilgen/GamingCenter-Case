//
//  DetailVC.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import UIKit
import SDWebImage

protocol GameDetailViewInterface: AnyObject {
    func configure()
    
    func isWebsiteAvailable(_ state: Bool)
    func isRedditAvailable(_ state: Bool)
    
    func addToFavourites(id: Int)
    
    func showAlert(title: String, message: String)
    
    func setup(name: String, description: String, image: URL)
}

final class DetailVC: UIViewController {

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
        
    lazy var viewModel = GameDetailViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func visitReddit(_ sender: UIButton) {
        UIApplication.shared.open(viewModel.visitReddit())
    }
    
    @IBAction func visitWebsite(_ sender: UIButton) {
        UIApplication.shared.open(viewModel.visitWebsite())
    }
}

extension DetailVC: GameDetailViewInterface {
    func addToFavourites(id: Int) {
        
    }
    
    func isWebsiteAvailable(_ state: Bool) {
        setButton(state: state, button: gameVisitWebsiteButton)
    }
    
    func isRedditAvailable(_ state: Bool) {
        setButton(state: state, button: gameVisitRedditButton)
    }
    
    private func setButton(state: Bool, button: UIButton) {
        DispatchQueue.main.async {
            if state {
                button.alpha = 1
                button.isUserInteractionEnabled = true
            } else {
                button.alpha = 0.5
                button.isUserInteractionEnabled = false
            }
        }
    }
    
    func setup(name: String, description: String, image: URL) {
        DispatchQueue.main.async {
            self.gameDescriptionValueLabel.text = description
            name.put(to: self.gameTitleLabel)
            
            self.gameImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.gameImageView.sd_setImage(with: image)
        }
    }
    
    func configure() {
        DispatchQueue.main.async {
            let favouriteButton = UIBarButtonItem(title: self.viewModel.getBarButtonTitle(), style: .plain, target: self, action: #selector(self.favoriteTapped))
            self.navigationItem.rightBarButtonItem = favouriteButton
            
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    @objc func favoriteTapped() {
        viewModel.favoriteTapped()
    }
    
    func showAlert(title: String, message: String) {
        Alert.show(on: self, title: title, message: message)
    }
}
