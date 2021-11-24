//
//  ButtonBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import UIKit

extension UIButton {
    
    func title(_ title: String, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    func image(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    func titleColor(_ textColor: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(textColor, for: state)
        return self
    }
}

extension UIBarButtonItem {
    
    func tintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
}
