//
//  HomeGiffCell.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 16/03/2021.
//

import UIKit
import SwiftyGif

extension Giff.My {
    
    final class CollectionCell: UICollectionViewCell, VerticalCollectionCell {
        
        let imageView = UIImageView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.trailing.leading.bottom.equalToSuperview()
                make.top.equalToSuperview().offset(.tiny)
            }
        }
 
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            imageView.clear()
        }
        
        private func configure(with data: Data) {
            let gif = UIImage(data: data)
            imageView.animationImages = gif?.images
            imageView.animationDuration = gif!.duration / 2
            imageView.startAnimating()
        }
        
        func configure(with cellType: VerticalCollectionCellType) {
            guard case let .gif(data) = cellType else { return }
            configure(with: data)
        }
    }
}
