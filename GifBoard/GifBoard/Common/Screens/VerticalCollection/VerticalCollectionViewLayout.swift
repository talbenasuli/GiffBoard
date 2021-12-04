//
//  HomeCollectionViewLayout.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import UIKit


final class VerticalCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        minimumInteritemSpacing = CGFloat(App.Padding.tiny.rawValue)
        minimumLineSpacing = CGFloat(App.Padding.big.rawValue)
        scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

