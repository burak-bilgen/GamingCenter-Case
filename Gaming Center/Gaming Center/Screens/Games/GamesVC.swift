//
//  GamesVC.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import UIKit

protocol GamesViewInterface: AnyObject {
    func configure()
    func reloadData()
    func showEmptyView()
    func showAlert(title: String, message: String)
}

final class GamesVC: UIViewController {
    
    private lazy var viewModel = GamesViewModel(view: self)
    
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

extension GamesVC: GamesViewInterface {
    func showEmptyView() {
        tableView.isHidden = true
    }
    
    func configure() {
        tableView.register(UINib(nibName: Name.cellName, bundle: nil), forCellReuseIdentifier: Name.cellName)
    }
    
    func showAlert(title: String, message: String) {
        Alert.show(on: self, title: title, message: message)
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}

extension GamesVC: TableView {
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
        viewModel.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(Size.cellHeight)
    }
}
