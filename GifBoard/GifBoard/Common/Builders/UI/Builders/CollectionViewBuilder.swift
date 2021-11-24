//
//  CollectionViewBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 17/03/2021.
//

import UIKit

extension UICollectionView {
    
    func delegate(_ delegate: UICollectionViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    func keyboardDismissMode(_ keyboardDismissMode: KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = keyboardDismissMode
        return self
    }
}
