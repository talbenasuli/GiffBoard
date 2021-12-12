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
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}

