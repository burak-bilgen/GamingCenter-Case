//
//  FavoritesVC.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import UIKit

protocol FavoritesViewInterface: AnyObject {
    func configure()
    func reloadData()
    func showEmptyView()
    func showAlert(title: String, message: String)
}

class FavoritesVC: UIViewController {
    
    private lazy var viewModel = FavoritesViewModel(view: self)

    @IBOutlet weak var emptyDataLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
}

extension FavoritesVC: FavoritesViewInterface {
    func showEmptyView() {
        emptyDataLabel.isHidden = false
        tableView.isHidden = true
    }
    
    func hideEmptyView() {
        emptyDataLabel.isHidden = true
        tableView.isHidden = false
    }
    
    func configure() {
        tableView.register(UINib(nibName: Name.cellName, bundle: nil), forCellReuseIdentifier: Name.cellName)
        
        guard let list = viewModel.gameList else { return }
        if list.count == 0 {
            showEmptyView()
        } else {
            hideEmptyView()
        }
    }
    
    func showAlert(title: String, message: String) {
        Alert.show(on: self, title: title, message: message)
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoritesVC: TableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Name.cellName, for: indexPath) as? GameListCell else { return UITableViewCell() }
        guard let data = viewModel.dataForRow(at: indexPath.row) else { return UITableViewCell() }
        
        cell.configure(with: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailView = UIStoryboard(name: Headlines.detail, bundle: nil).instantiateViewController(withIdentifier: ViewController.detailVC) as? DetailVC else { return }
        
        guard let game = viewModel.gameList?[indexPath.row], let selectedID = game.id else { return }
        detailView.viewModel.cellData = game
        detailView.viewModel.id = selectedID
        
        navigationController?.show(detailView, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(Size.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Alert.show(on: self, title: Headlines.caution, message: "Favourite game will be deleted, are you sure?", cancelButton: "Cancel") {
                self.viewModel.removeCell(at: indexPath.row)
            }
        }
    }
}
