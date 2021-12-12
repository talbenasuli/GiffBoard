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
            self.repo = repo
            setupNavigation()
            getGifs()
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: Notification.Name("GifUpdate"), object: nil)
        }
        
        func item(at index: IndexPath) -> VerticalCollectionCellType {
            return collectionItems.value[index.row]
        }
        
        @objc private func update() {
            updateGifs()
        }
    }
}

private extension Giff.My.ViewModel {
    
    func updateGifs() {
        let lastIndex = UserDefaults.standard.integer(forKey: "numberOfGifs") - 1
        guard lastIndex >= 0 else { return }
        let viewModel = Giff.My.CellViewModel(index: lastIndex, repo: repo)
        let cellType = VerticalCollectionCellType.gif(viewModel)
        var items = collectionItems.value
        items.append(cellType)
        collectionItems.accept(items)
    }
    
    func setupNavigation() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
            .tintColor(.black)
        
        plusButton.rx.tap
            .map {
                print("number of items: \(self.collectionItems.value.count)")
                return self.collectionItems.value.count
            }
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
    
    func getGifs() {
        let numberOfGifs = UserDefaults.standard.integer(forKey: "numberOfGifs")
        guard numberOfGifs != 0 else { return }
        let cellsType = (0..<numberOfGifs)
            .map { Giff.My.CellViewModel(index: $0, repo: repo) }
            .map { VerticalCollectionCellType.gif($0) }
        collectionItems.accept(cellsType)
    }
}
