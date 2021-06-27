//
//  ViewBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/03/2021.
//

import UIKit

extension UIView {
    
    func add(_ subviews: UIView...) {
        
        for view in subviews {
            addSubview(view)
        }
    }
    
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    func borderColor(_ color: UIColor) -> Self {
        layer.borderColor = UIColor.white.cgColor
        return self
    }
    
    func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }
    
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        return self
    }
}

