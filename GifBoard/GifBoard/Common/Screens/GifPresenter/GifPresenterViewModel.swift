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
        
        private var finishedProcess = false
        private var gifData: Data?
        private let loading = BehaviorRelay<Bool>(value: false)
        
        private let repo: CameraRepo

        let disposeBag = DisposeBag()
                
        init(images: [UIImage],
             animationDuration: TimeInterval,
             numberOfGifs: Int,
             repo: CameraRepo) {
        
            self.repo = repo
            
            input = GifPresenterViewModelInput(images: images, animationDuration: animationDuration, buttonTitle: "Save", bottomButtonTapped: PublishRelay<Void>(), gifFinished: PublishRelay<Data>(), undoTapped: PublishRelay<Void>())
            
            let done = PublishRelay<Void>()
            let gifCopied = PublishRelay<String>()

            output = GifPresenterViewModelOutput(loading: loading.asDriver(onErrorDriveWith: .never()),
                                                 undoTapped: input.undoTapped.asDriver(onErrorDriveWith: .never()),
                                                 done: done.asDriver(onErrorDriveWith: .never()),
                                                 gifCopied: gifCopied.asDriver(onErrorDriveWith: .never()))
            
            func handleGif() {
                
                let folder = "GifIndex\(numberOfGifs)"
                let gifContent = Camera.GifContent(duration: animationDuration)
                
                let save = repo.save(images: images, into: folder, andWith: gifContent)
                    .asObservable()
                    .materialize()
                    .share()
                
                save
                    .map { _ in return false }
                    .bind(to: loading)
                    .disposed(by: disposeBag)
                
                save
                    .compactMap { $0.element }
                    .bind(to: done)
                    .disposed(by: disposeBag)
                
                save
                    .compactMap { $0.element }
                    .subscribe(onNext: {
                        UserDefaults.standard.set(numberOfGifs, forKey: "gifLastIndex")
                    })
                    .disposed(by: disposeBag)
            }
            
            input.bottomButtonTapped
                .subscribe(onNext: { [weak self] in
                    self?.loading.accept(true)
                    if self?.finishedProcess == true, let data = self?.gifData {
                        handleGif()
                    }
                }).disposed(by: disposeBag)
            
            input.gifFinished
                .subscribe(onNext: { [weak self] data in
                    let userTapSave = self?.loading.value == true
                    
                    if userTapSave {
                        handleGif()
                    } else {
                        self?.finishedProcess = true
                        self?.gifData = data
                    }
                }).disposed(by: disposeBag)
        }
    }
}
