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
}

