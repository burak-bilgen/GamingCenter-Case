//
//  String+Extensions.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 11.02.2023.
//

import UIKit

extension String {
    func put(to label: UILabel) {
        label.text = self
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
