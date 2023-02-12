//
//  DetailVM.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 13.02.2023.
//

import Foundation

protocol GameDetailViewModelInterface: AnyObject {
    var view: GameDetailViewInterface? { get set }
    
    func viewDidLoad()
        
    func visitWebsite() -> URL
    func visitReddit() -> URL
    
    func fetchGameDetail()
    
    func favoriteTapped()
    
    func getBarButtonTitle() ->  String
}

final class GameDetailViewModel {
    weak var view: GameDetailViewInterface?
    
    var id: Int = 0
    var game: DetailedGame?
        
    var redditURL: URL?
    var websiteURL: URL?
    
    var isFavourite: Bool = false
    
    init(view: GameDetailViewInterface?) {
        self.view = view
    }
}

extension GameDetailViewModel: GameDetailViewModelInterface {
    func favoriteTapped() {
        if let favouriteStatus = UserDefaults.standard.object(forKey: Headlines.favouriteGames) as? [Int] {
            var tempArray = favouriteStatus
            
            if tempArray.contains(id) {
                removeFromFavourites(tempArray)
            } else {
                tempArray.append(id)
                saveFavourites(tempArray)
            }
        } else {
            var tempArray = [Int]()
            tempArray.append(id)
            saveFavourites(tempArray)
        }
        
        setFavouriteStatus()
        view?.configure()
    }
    
    private func saveFavourites(_ array: [Int]?) {
        if let array {
            UserDefaults.standard.set(array, forKey: Headlines.favouriteGames)
        }
    }
    
    private func removeFromFavourites(_ array: [Int]?) {
        if var cacheArray = array {
            cacheArray = cacheArray.filter {
                $0 != id
            }
            
            saveFavourites(cacheArray)
        }
    }
    
    func getBarButtonTitle() -> String {
        isFavourite ? Headlines.favorited : Headlines.notFavorited
    }
    
    func setFavouriteStatus() {
        guard let favouriteStatus = UserDefaults.standard.object(forKey: Headlines.favouriteGames) as? [Int] else { return }

        isFavourite = favouriteStatus.contains(id)
    }
    
    func viewDidLoad() {
        fetchGameDetail()
    }
    
    func fetchGameDetail() {
        GameDetailManager.fetchGameDetail(with: id) { [weak self] game, error in
            guard let self, let game else { return }
            
            if let error {
                self.view?.showAlert(title: Headlines.caution, message: error)
            } else {
                if let name = game.name,
                    let description = game.description_raw,
                    let image = game.background_image,
                    let imgURL = URL(string: image) {
                    self.view?.setup(name: name, description: description, image: imgURL)
                }
                
                if let website = game.website, let finalURL = URL(string: website) {
                    self.view?.isWebsiteAvailable(true)
                    self.websiteURL = finalURL
                } else {
                    self.view?.isWebsiteAvailable(false)
                }
                
                if let reddit = game.reddit_url, let finalURL = URL(string: reddit) {
                    self.view?.isRedditAvailable(true)
                    self.redditURL = finalURL
                } else {
                    self.view?.isRedditAvailable(false)
                }
                
                self.setFavouriteStatus()
                
                self.view?.configure()
            }
        }
    }
    
    func visitWebsite() -> URL {
        websiteURL ?? URL(string: NetworkHelper.docs_url)!
    }
    
    func visitReddit() -> URL {
        redditURL ?? URL(string: NetworkHelper.docs_url)!
    }
}
