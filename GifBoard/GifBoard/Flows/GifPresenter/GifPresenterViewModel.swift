//
//  GifPresenterViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 15/11/2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension Giff {
    
    final class PresenterViewModel: GifPresenterViewModelType {
        
        var input: GifPresenterViewModelInput
        var output: GifPresenterViewModelOutput
        
        let disposeBag = DisposeBag()
        
        init(images: [UIImage], animationDuration: TimeInterval) {
            
            input = GifPresenterViewModelInput(images: images, animationDuration: animationDuration, buttonTitle: "Save", bottomButtonTapped: PublishRelay<Void>(), gifFinished: PublishRelay<Void>(), undoTapped: PublishRelay<Void>())
            
            let loading = BehaviorRelay<Bool>(value: false)
            
            input.bottomButtonTapped
                .map { return true }
                .bind(to: loading)
                .disposed(by: disposeBag)
            
            input.gifFinished
                .map { return false }
                .bind(to: loading)
                .disposed(by: disposeBag)
            
            output = GifPresenterViewModelOutput(loading: loading.asDriver(onErrorDriveWith: .never()),
                                                 undoTapped: input.undoTapped.asDriver(onErrorDriveWith: .never()))
        }
    }
}
