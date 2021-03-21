//
//  HomeViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension Home {
    
    final class ViewModel: HomeViewModelType {
                
        var title: String = "Giffs"
        var searchPlaceHolder: String = "Search"
        var leftSegmentTitle: String = "All"
        var rightSegementTitle: String = "Mine"
        
        let disposeBag = DisposeBag()
        
        private let homeRepo: HomeRepoType
        private let limit = 100
        private var searchOffset = 0
        
        private let _items = BehaviorRelay<[ViewController.CellType]>(value: [])
        lazy var items = _items.asDriver(onErrorJustReturn: [])
        
        var searchText = BehaviorRelay<String?>(value: nil)
        var onSearchTappd = PublishRelay<Void>()
        var scrollToEnd = PublishRelay<Void>()
        
        var strong: Home.Coordinator?
        
        
        init(homeRepo: HomeRepoType = Home.Repo()) {
            self.homeRepo = homeRepo
            subscribeObservables()
        }
        
        func start() {
            downloadGiffs()
        }
        
        func item(at indexPath: IndexPath) -> ViewController.CellType {
            return _items.value[indexPath.row]
        }
    }
}

private extension Home.ViewModel {
    
    func subscribeObservables() {
        
        onSearchTappd.subscribe(onNext: { [weak self] in
            self?.searchOffset = 0
            self?.search()
        }).disposed(by: disposeBag)
        
        scrollToEnd.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.searchOffset = self.searchOffset + 1
            self.search()
        }).disposed(by: disposeBag)
    }
    
    func downloadGiffs() {
        search()
    }
    
    func search() {
        print("search offset: \(searchOffset)")
        homeRepo.search(body: Giff.Body(query: searchText.value ?? "", limit: limit, offset: searchOffset))
            .subscribe { [weak self] giffResponse in
                if let cellTypes = giffResponse.data?.compactMap({ Home.ViewController.CellType.giff(data: $0) }) {
                    guard let self = self else { return }
                    
                    if self.searchOffset == 0 {
                        self._items.accept(cellTypes)
                    } else {
                        let items = self._items.value + cellTypes
                        self._items.accept(items)
                    }
                } else {
                    self?._items.accept([])
                }
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
}
