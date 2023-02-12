//
//  GamesVM.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

protocol GamesViewModelInterface: AnyObject {
    var view: GamesViewInterface? { get set }
    
    func viewDidLoad()
    func fetchGameList()
    func dataForRow(at: Int) -> GameItemProtocol?
    func numberOfRows() -> Int
    func didSelectRowAt(index: Int)
}

final class GamesViewModel {
    weak var view: GamesViewInterface?
    
    var gameList: GameList? = nil
    
    init(view: GamesViewInterface?) {
        self.view = view
    }
}

extension GamesViewModel: GamesViewModelInterface {
    func dataForRow(at index: Int) -> GameItemProtocol? {
        guard let gameList else { return nil }
        return gameList.results?[index]
    }
    
    func numberOfRows() -> Int {
        guard let count = gameList?.results?.count else { return 0 }
    
        return count
    }
    
    func didSelectRowAt(index: Int) {
        
    }
    
    func viewDidLoad() {
        view?.configure()
        fetchGameList()
    }
    
    func fetchGameList() {
        GameListManager.fetchGameList(with: nil) { [weak self] data, error in
            guard let self else { return }

            if let error {
                self.view?.showAlert(title: "Caution", message: error)
            } else {
                guard let data, let result = data.results, result.count > 0 else {
                    self.view?.showEmptyView()
                    return
                }
                
                self.gameList = data
                self.view?.reloadData()
            }
        }
    }
}
