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
                
    func dataForRow(at: Int) -> GameItemProtocol?
    func numberOfRows() -> Int
}

final class FavoritesViewModel {
    weak var view: FavoritesViewInterface?
    
    var gameList: [Game]? = []
    
    init(view: FavoritesViewInterface?) {
        self.view = view
    }
}

extension FavoritesViewModel: FavoritesViewModelInterface {
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
