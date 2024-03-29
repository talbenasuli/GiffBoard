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
        private let loading = BehaviorRelay<Bool>(value: false)
        
        private let repo: CameraRepo

        let disposeBag = DisposeBag()
                
        init(images: [UIImage],
             animationDuration: TimeInterval,
             numberOfGifs: Int,
             repo: CameraRepo) {
        
            self.repo = repo
            
            input = GifPresenterViewModelInput(images: images, animationDuration: animationDuration, buttonTitle: "Save", bottomButtonTapped: PublishRelay<Void>(), gifFinished: PublishRelay<Void>(), undoTapped: PublishRelay<Void>())
            
            let done = PublishRelay<Void>()
            let gifCopied = PublishRelay<String>()

            output = GifPresenterViewModelOutput(loading: loading.asDriver(onErrorDriveWith: .never()),
                                                 undoTapped: input.undoTapped.asDriver(onErrorDriveWith: .never()),
                                                 done: done.asDriver(onErrorDriveWith: .never()),
                                                 gifCopied: gifCopied.asDriver(onErrorDriveWith: .never()))
            
            func handleGif() {
                let folder = "GifIndex\(numberOfGifs)"
                let gifContent = Camera.GifContent(duration: animationDuration, imagesCount: images.count)
                
                repo.save(images: images, into: folder, andWith: gifContent)
                    .subscribe { [weak self] in
                        self?.loading.accept(false)
                        UserDefaults.standard.set(numberOfGifs + 1, forKey: "numberOfGifs")
                        NotificationCenter.default.post(name: Notification.Name("GifUpdate"), object: nil)

                        done.accept((()))
                    } onError: { _ in }
                    .disposed(by: disposeBag)
            }
            
            input.bottomButtonTapped
                .subscribe(onNext: { [weak self] in
                    self?.loading.accept(true)
                    if self?.finishedProcess == true {
                        handleGif()
                    }
                }).disposed(by: disposeBag)
            
            input.gifFinished
                .subscribe(onNext: { [weak self] in
                    let userTapSave = self?.loading.value == true
                    
                    if userTapSave {
                        handleGif()
                    } else {
                        self?.finishedProcess = true
                    }
                }).disposed(by: disposeBag)
        }
    }
}
