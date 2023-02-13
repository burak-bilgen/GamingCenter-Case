//
//  FavoritesVM.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 13.02.2023.
//

import Foundation

protocol FavoritesViewModelInterface: AnyObject {
    var view: FavoritesViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func fetchGameList()
    
    func removeCell(at: Int)
                
    func dataForRow(at: Int) -> GameItemProtocol?
    func numberOfRows() -> Int
}

final class FavoritesViewModel {
    weak var view: FavoritesViewInterface?
    
    var gameList: [Game]?
    
    init(view: FavoritesViewInterface?) {
        self.view = view
    }
}

extension FavoritesViewModel: FavoritesViewModelInterface {
    func removeCell(at index: Int) {
        guard let item = gameList?[index] else { return }
        if doesItContain(item: item, container: gameList) {
            removeFromFavourites(item: item, container: gameList)
        }
    }
    
    private func doesItContain(item: Game, container: [Game]?) -> Bool {
        if let container {
            return container.contains(where: { $0.id == item.id })
        } else {
            return false
        }
    }
    
    private func removeFromFavourites(item: Game, container: [Game]?) {
        let editedContainer = container?.filter { $0.id != item.id }
        saveFavourites(container: editedContainer)
    }
    
    private func saveFavourites(container: [Game]?) {
        if let container {
            let encodedStoredItems = try? JSONEncoder().encode(container)
            UserDefaults.standard.set(encodedStoredItems, forKey: UserDefaultsKey.favorites)
            fetchGameList()
        }
    }
    
    func viewWillAppear() {
        fetchGameList()
    }
    
    func dataForRow(at index: Int) -> GameItemProtocol? {
        guard let gameList else { return nil }
        return gameList[index]
    }
    
    func numberOfRows() -> Int {
        guard let count = gameList?.count else { return 0 }
    
        return count
    }
    
    func viewDidLoad() {
        fetchGameList()
    }
    
    func fetchGameList() {
        let storedItems = UserDefaults.standard.object(forKey: UserDefaultsKey.favorites)
        
        if let data = storedItems as? Data {
            let decodedStoredItems = try? JSONDecoder().decode([Game].self, from: data)
            gameList = decodedStoredItems
            
            view?.configure()
            view?.reloadData()
        }
    }
}
