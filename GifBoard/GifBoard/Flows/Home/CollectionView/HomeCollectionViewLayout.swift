//
//  HomeCollectionViewLayout.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import UIKit

extension Home {
    
    final class CollectionViewLayout: UICollectionViewFlowLayout {
        
        override init() {
            super.init()
            minimumInteritemSpacing = CGFloat(App.Padding.tiny.rawValue)
            minimumLineSpacing = 0
            scrollDirection = .vertical
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}
