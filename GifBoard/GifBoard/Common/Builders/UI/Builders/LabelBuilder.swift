//
//  LabelBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit

extension UILabel {
    
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
}
