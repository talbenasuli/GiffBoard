//
//  MyGifCollectionViewCell.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 06/12/2021.
//

import UIKit
import RxSwift
import RxRelay

extension Giff.My {
    
    final class CellViewModel {
        
        private let index: Int
        private let repo: Repo.Base
        
        let disposeBag = DisposeBag()
        
        private let _loading = BehaviorRelay<Bool>(value: false)
        lazy var loading = _loading.asDriver(onErrorDriveWith: .never())
        
        private let _images = PublishRelay<([UIImage], Camera.GifContent)>()
        lazy var images = _images.asDriver(onErrorDriveWith: .never())
        
        init(index: Int, repo: Repo.Base) {
            self.index = index
            self.repo = repo
            getGif()
        }
    }
}

private extension Giff.My.CellViewModel {

    func getGif() {
    
        _loading.accept(true)
        
        let gifImages = repo.getMyGif(index: index)
            .asObservable()
            .materialize()
            .share()
        
        gifImages
            .compactMap { $0.element }
            .bind(to: _images)
            .disposed(by: disposeBag)
        
        gifImages
            .compactMap { _ in return false }
            .bind(to: _loading)
            .disposed(by: disposeBag)
    }
}
