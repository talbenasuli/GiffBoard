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
        
        let index: Int
        private let repo: Repo.Base
        private var didFetch: Bool = false
        
        let disposeBag = DisposeBag()
        
        private let _loading = BehaviorRelay<Bool>(value: false)
        lazy var loading = _loading.asDriver(onErrorDriveWith: .never())
        
        private let _images = PublishRelay<([UIImage], Camera.GifContent)>()
        lazy var images = _images.asDriver(onErrorDriveWith: .never())
        
        init(index: Int, repo: Repo.Base) {
            self.index = index
            self.repo = repo
        }
        
        func start() {
            getGif()
        }
    }
}

private extension Giff.My.CellViewModel {

    func getGif() {
        guard !didFetch else { return }

        _loading.accept(true)
        
        repo.getMyGif(index: index)
            .compactMap({ (images, content) in
                return (Array(images.prefix(20).map { $0.thumbnail(size: 130) } ), content)
            })
            .subscribe { [weak self] (images, content) in
                guard let self = self else { return }
                self._images.accept((images, content))
                self._loading.accept(false)
                self.didFetch = true
            } onError: { [weak self] error in
                guard let self = self else { return }
                self._loading.accept(false)
                print(error)
            }.disposed(by: disposeBag)
    }
}
