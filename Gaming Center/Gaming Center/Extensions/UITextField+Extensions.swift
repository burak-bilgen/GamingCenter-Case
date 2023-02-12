//
//  UITextField+Extensions.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import UIKit

@IBDesignable
class CustomUITextField: UITextField {
    @IBInspectable var leftImage: UIImage? = nil
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var gapPadding: CGFloat = 0
    
    private var textPadding: UIEdgeInsets {
        let p: CGFloat = leftPadding + gapPadding + (leftView?.frame.width ?? 0)
        return UIEdgeInsets(top: 0, left: p, bottom: 0, right: 5)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.leftViewRect(forBounds: bounds)
        r.origin.x += leftPadding
        return r
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        if let image = leftImage {
            if leftView != nil { return }
            
            let im = UIImageView()
            im.contentMode = .scaleAspectFit
            im.image = image
            
            leftViewMode = UITextField.ViewMode.always
            leftView = im
            
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}
