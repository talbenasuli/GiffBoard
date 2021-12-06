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
        
        private func configure(with viewModel: Giff.My.CellViewModel) {
            viewModel.images.drive(onNext: { [weak self] data in
                let images = data.0
                let content = data.1
                
                self?.imageView.animationImages = images
                self?.imageView.animationDuration = content.duration
                self?.imageView.startAnimating()
            }).disposed(by: viewModel.disposeBag)
        }
        
        func configure(with cellType: VerticalCollectionCellType) {
            guard case let .gif(viewModel) = cellType else { return }
            configure(with: viewModel)
        }
    }
}
