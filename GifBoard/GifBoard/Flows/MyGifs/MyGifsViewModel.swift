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
        
        var navigationStyles: [BarStyle] {
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
                .tintColor(.black)
            
            rightButton.rx.tap
                .bind(to: input.navigationPlusTapped)
                .disposed(by: disposeBag)
           
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 117, height: 33))
            imageView.image = UIImage(named: "navigation_logo")
            let logo = UIBarButtonItem.init(customView: imageView)
            
            return [.background(color: .clear),
                        .separator(.clear),
                        .right(buttons: [rightButton]),
                        .left(buttons: [logo])]
        }
        
        var input = VerticalCollectionViewModelInput()
        lazy var output = VerticalCollectionViewModelOutput(navigationPlusTapped: input.navigationPlusTapped.asDriver(onErrorDriveWith: .never()),
                                             loading: loading.asDriver(onErrorDriveWith: .never()))
        
        private var loading = BehaviorRelay<Bool>(value: false)
        
        private var repo: Repo.Base
        
        init(repo: Repo.Base) {
            self.repo = repo
            getGifs()
        }
    }
}

private extension Giff.My.ViewModel {
    
    func getGifs() {
        
//        let gifs = repo.getMyGifs(page: 0)
//            .map { }
//        
//        repo.getMyGifs(page: 0)
//            .asObservable()
//            .bind(to: <#T##Variable<[Data]>#>)
    }
}
