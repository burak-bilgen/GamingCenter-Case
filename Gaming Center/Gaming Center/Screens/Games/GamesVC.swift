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
    func scrollToTop()
    func showEmptyView()
    func showAlert(title: String, message: String)
}

final class GamesVC: UIViewController {
    
    private lazy var viewModel = GamesViewModel(view: self)
    
    @IBOutlet weak var emptyDataLabel: UILabel!
        
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchFieldView: UIView!
    
    @IBOutlet weak var scrollButton: UIButton!
        
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

extension GamesVC: GamesViewInterface {
    private func createTableViewSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    @IBAction func scrollToTop(_ sender: UIButton) {
        scrollToTop()
    }
    
    func scrollButton(hide: Bool) {
        UIView.animate(withDuration: 0.25, delay: 0) {
            if hide {
                self.scrollButton.alpha = 0
            } else {
                self.scrollButton.alpha = 1
            }
        }
    }
    
    func showEmptyView() {
        tableView.isHidden = true
    }
    
    func configure() {
        scrollButton.layer.cornerRadius = scrollButton.frame.width / 2
        searchField.layer.cornerRadius = 10
        
        searchField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)

        tableView.register(UINib(nibName: Name.cellName, bundle: nil), forCellReuseIdentifier: Name.cellName)
    }
    
    @objc func textFieldTextChanged() {
        guard let text = searchField.text else { return }
        viewModel.search(text: text)
    }
    
    func showAlert(title: String, message: String) {
        Alert.show(on: self, title: title, message: message)
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.tableFooterView = nil
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > 100 {
            scrollButton(hide: false)
        } else {
            scrollButton(hide: true)
        }
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !viewModel.isFetchingData else { return }
            
            tableView.tableFooterView = createTableViewSpinner()
            
            viewModel.increasePageCount()
            
            if searchField.text!.count > 0 {
                textFieldTextChanged()
            } else {
                viewModel.fetchGameList()
            }
        }
    }
}
