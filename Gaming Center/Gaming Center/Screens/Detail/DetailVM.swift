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
    var cellData: Game?
    var game: DetailedGame?
        
    var redditURL: URL?
    var websiteURL: URL?
    
    var isFavourite: Bool = false
    
    init(view: GameDetailViewInterface?) {
        self.view = view
    }
}

extension GameDetailViewModel: GameDetailViewModelInterface {
    private func getStoredItems() -> [Game] {
        let storedItems = UserDefaults.standard.object(forKey: UserDefaultsKey.favorites)

        if let data = storedItems as? Data {
            if let decodedStoredItems = try? JSONDecoder().decode([Game].self, from: data) {
                return decodedStoredItems
            }
        }
        
        return [Game]()
    }
    
    private func doesItContain(item: Game, container: [Game]?) -> Bool {
        if let container {
            return container.contains(where: { $0.id == item.id })
        } else {
            return false
        }
    }
    
    func favoriteTapped() {
        guard let cellData else { return }
        
        var items = getStoredItems()
        
        if doesItContain(item: cellData, container: items) {
            removeFromFavourites(item: cellData, container: items)
        } else {
            items.append(cellData)
            saveFavourites(container: items)
        }
        
        isFavourite = doesItContain(item: cellData, container: getStoredItems())
        view?.configure()
    }
    
    private func saveFavourites(container: [Game]?) {
        if let container {
            let encodedStoredItems = try? JSONEncoder().encode(container)
            UserDefaults.standard.set(encodedStoredItems, forKey: UserDefaultsKey.favorites)
        }
    }
    
    private func removeFromFavourites(item: Game, container: [Game]?) {
        let editedContainer = container?.filter { $0.id != item.id }
        saveFavourites(container: editedContainer)
    }
    
    func getBarButtonTitle() -> String {
        isFavourite ? Collection.favorited : Collection.notFavorited
    }

    func viewDidLoad() {
        fetchGameDetail()
    }
    
    func fetchGameDetail() {
        GameDetailManager.fetchGameDetail(with: id) { [weak self] game, error in
            guard let self, let game, let cellData = self.cellData else { return }
            
            if let error {
                self.view?.showAlert(title: Headlines.caution, message: error)
            } else {
                self.game = game
                
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
                
                self.isFavourite = self.doesItContain(item: cellData, container: self.getStoredItems())
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
