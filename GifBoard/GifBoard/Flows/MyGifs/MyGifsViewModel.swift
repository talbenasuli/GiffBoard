//
//  MyGifsViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

extension Giff.My {
    
    final class ViewModel: VerticalCollectionViewModelType {
        
        let disposeBag = DisposeBag()
        
        var navigationStyles: [BarStyle] = []
        
        var input = VerticalCollectionViewModelInput()
        lazy var output = VerticalCollectionViewModelOutput(navigationPlusTapped: input.navigationPlusTapped.asDriver(onErrorDriveWith: .never()),
                                                            loading: loading.asDriver(onErrorDriveWith: .never()),
                                                            collectionItems: collectionItems.asDriver(onErrorDriveWith: .never()),
                                                            navigationGifyTapped: gifNavButtonTapped.asDriver(onErrorDriveWith: .never()))
        
        private var loading = BehaviorRelay<Bool>(value: false)
        private let collectionItems = BehaviorRelay<[VerticalCollectionCellType]>(value: [])
        private let gifNavButtonTapped = PublishRelay<Void>()
        
        private var repo: Repo.Base
        
        init(repo: Repo.Base) {
            let gifsLastIndex = UserDefaults.standard.integer(forKey: "gifLastIndex")
            self.repo = repo
            setupNavigation()
            getGifs(until: gifsLastIndex)
        }
        
        func item(at index: IndexPath) -> VerticalCollectionCellType {
            return collectionItems.value[index.row]
        }
    }
}

private extension Giff.My.ViewModel {
    
    func setupNavigation() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
            .tintColor(.black)
        
        plusButton.rx.tap
            .map { self.collectionItems.value.count }
            .bind(to: input.navigationPlusTapped)
            .disposed(by: disposeBag)
        
        let gifsButton = UIBarButtonItem(image: UIImage(named: "nav-gif-icon"), style: .plain, target: nil, action: nil)
        
        gifsButton.rx.tap
            .bind(to: gifNavButtonTapped)
            .disposed(by: disposeBag)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 117, height: 33))
        imageView.image = UIImage(named: "navigation_logo")
        let logo = UIBarButtonItem.init(customView: imageView)
        
        navigationStyles = [.background(color: .clear),
                            .separator(.clear),
                            .right(buttons: [plusButton, gifsButton]),
                            .left(buttons: [logo])]
    }
    
    func getGifs(until lastIndex: Int) {
        
        let cellsType = (0...lastIndex)
            .map { Giff.My.CellViewModel(index: $0, repo: repo) }
            .map { VerticalCollectionCellType.gif($0) }
        collectionItems.accept(cellsType)
        
//        repo.getMyGif(index: 0)
//            .asObservable()
//            .subscribe { data in
//                let items = data.map { VerticalCollectionCellType.gif($0) }
//                self.collectionItems.accept(items)
//            } onError: { error in }
//            .disposed(by: disposeBag)

    }
}
