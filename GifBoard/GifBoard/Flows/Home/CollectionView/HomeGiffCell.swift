//
//  HomeGiffCell.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 16/03/2021.
//

import UIKit
import SwiftyGif

extension Home {
    
    final class GiffCell: UICollectionViewCell {
        
        let imageView = UIImageView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(50)
                make.trailing.leading.bottom.equalToSuperview()
                make.top.equalToSuperview().offset(.tiny)
            }
        }
 
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            imageView.setImage(UIColor.App.white.image())
        }
        
        func configure(with data: Giff.Data) {
            guard let link = data.images?.downsized?.url,
                  let hight = Int(data.images?.downsized?.height ?? "0"),
                  let width = Int(data.images?.downsized?.width ?? "0"),
                  let imageURL = URL(string: link) else { return }
            let loader = UIActivityIndicatorView(style: .gray)
            imageView.setGifFromURL(imageURL, customLoader: loader)

            imageView.snp.updateConstraints { make in
                make.height.equalTo(hight)
                make.width.equalTo(width)
            }
        }
    }
}
