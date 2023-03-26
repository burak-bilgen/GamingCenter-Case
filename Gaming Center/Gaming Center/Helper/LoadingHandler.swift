//
//  LoadingHandler.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 26.03.2023.
//

import UIKit

protocol LoadingHandler {
    func showLoading()
    func hideLoading()
}

extension LoadingHandler where Self: UIViewController {
    func showLoading() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        
        self.view.subviews.forEach({ view in
            if let tableView = view as? UITableView {
                tableView.tableFooterView = footerView
            }
        })
        
        spinner.startAnimating()
    }
    
    func hideLoading() {
        guard let tableView = self.view.subviews.first(where: { $0 === UITableView.self }) as? UITableView else { return }
        
        tableView.tableFooterView = UIView()
    }
}
