//
//  ImageViewBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/03/2021.
//

import UIKit

extension UIImageView {
    
    func image(named: String) -> Self {
        return image(UIImage(named: named))
    }
    
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
}
