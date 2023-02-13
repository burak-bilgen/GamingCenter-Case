//
//  AlertView.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import UIKit

class Alert {
    static func show(on view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        view.present(alert, animated: true)
    }
    
    static func show(on view: UIViewController, title: String, message: String, cancelButton: String, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { _ in
            completion()
        }))
        
        alert.addAction(UIAlertAction(title: cancelButton, style: UIAlertAction.Style.default, handler: nil))
        
        view.present(alert, animated: true)
    }
}
