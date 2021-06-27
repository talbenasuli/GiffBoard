//
//  SegmentedControlBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import UIKit

extension UISegmentedControl {
    
    func image(_ image: UIImage?, forSegmentAt index: Int) -> Self {
        self.setImage(image, forSegmentAt: index)
        return self
    }
    
    func image(named: String, forSegmentAt index: Int) -> Self {
        return image(UIImage(named: named), forSegmentAt: index)
    }
    
    func title(_ title: String?, forSegmentAt index: Int) -> Self {
        self.setTitle(title, forSegmentAt: index)
        return self
    }
    
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    func addSegment(withTitle title: String?, at index: Int, animated: Bool) -> Self {
        self.insertSegment(withTitle: title, at: index, animated: animated)
        return self
    }
    
    @available(iOS 13.0, *)
    func selectedSegmentTintColor(_ color: UIColor) -> Self {
        self.selectedSegmentTintColor = color
        return self
    }
    
    func selectSegment(at index: Int) -> Self {
        self.selectedSegmentIndex = index
        return self
    }
}
