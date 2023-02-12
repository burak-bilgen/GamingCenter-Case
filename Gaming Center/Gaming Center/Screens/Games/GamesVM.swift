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
    func fetchGameList(with input: String)
    
    func increasePageCount()
        
    func search(text input: String)
    
    func dataForRow(at: Int) -> GameItemProtocol?
    func numberOfRows() -> Int
}

final class GamesViewModel {
    weak var view: GamesViewInterface?
    
    var isFetchingData: Bool = false
    var gameList: [Game]? = []
    var pageCount = 1
    
    init(view: GamesViewInterface?) {
        self.view = view
    }
}

extension GamesViewModel: GamesViewModelInterface {
    func increasePageCount() {
        pageCount += 1
    }
    
    func search(text input: String) {
        if input.count >= 3 {
            fetchGameList(with: input)
        }
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
        view?.configure()
        fetchGameList()
    }
    
    func fetchGameList() {
        isFetchingData = true
        
        GameListManager.fetchGameList(with: nil, page: pageCount) { [weak self] data, error in
            guard let self else { return }

            self.isFetchingData = false

            if let error {
                self.view?.showAlert(title: Headlines.caution, message: error)
            } else {
                guard let data, let result = data.results, result.count > 0 else {
                    self.view?.showEmptyView()
                    return
                }
                
                self.gameList?.append(contentsOf: result)
                self.view?.reloadData()
            }
        }
    }
    
    func fetchGameList(with input: String) {
        isFetchingData = true
        
        GameListManager.fetchGameList(with: input, page: pageCount) { [weak self] data, error in
            guard let self else { return }
            
            self.isFetchingData = false

            if let error {
                self.view?.showAlert(title: Headlines.caution, message: error)
            } else {
                guard let data, let result = data.results, result.count > 0 else {
                    self.view?.showEmptyView()
                    return
                }
                
                self.gameList = result
                self.view?.reloadData()
            }
        }
    }
}
