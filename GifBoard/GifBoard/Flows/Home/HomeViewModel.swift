//
//  HomeViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import Foundation
import RxSwift

extension Home {
    
    final class ViewModel: HomeViewModelType {
        
        var title: String = "Giffs"
        var searchPlaceHolder: String = "Search"
        var leftSegmentTitle: String = "All"
        var rightSegementTitle: String = "Mine"
        
        let disposeBag = DisposeBag()
        
        private let homeRepo: HomeRepoType
        
        var strong: Home.Coordinator?
        
        init(homeRepo: HomeRepoType = Home.Repo()) {
            self.homeRepo = homeRepo
        }
        
        func start() {
            downloadGiffs()
        }
    }
}

private extension Home.ViewModel {
    
    private func downloadGiffs() {
       
        homeRepo.search(body: Giff.Body(query: "cats", limit: 20, offset: 0))
            .subscribe { giffResponse in
                print(giffResponse)
            } onError: { error in
               print(error)
            }.disposed(by: disposeBag)
    }
}
