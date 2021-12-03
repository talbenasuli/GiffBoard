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
import Disk

extension Giff {
    
    final class PresenterViewModel: GifPresenterViewModelType {
        
        var input: GifPresenterViewModelInput
        var output: GifPresenterViewModelOutput
        
        private var finishedProcess = false
        private var gifData: Data?
        private let loading = BehaviorRelay<Bool>(value: false)

        let disposeBag = DisposeBag()
                
        init(images: [UIImage],
             animationDuration: TimeInterval) {
        
            input = GifPresenterViewModelInput(images: images, animationDuration: animationDuration, buttonTitle: "Save", bottomButtonTapped: PublishRelay<Void>(), gifFinished: PublishRelay<Data>(), undoTapped: PublishRelay<Void>())
            
            let done = PublishRelay<Void>()
            let gifCopied = PublishRelay<String>()

            output = GifPresenterViewModelOutput(loading: loading.asDriver(onErrorDriveWith: .never()),
                                                 undoTapped: input.undoTapped.asDriver(onErrorDriveWith: .never()),
                                                 done: done.asDriver(onErrorDriveWith: .never()),
                                                 gifCopied: gifCopied.asDriver(onErrorDriveWith: .never()))
            
            func handleGif(_ data: Data) {
                UIPasteboard.general.setData(data, forPasteboardType: "com.compuserve.gif")

                do { // TBA NTD add handler for local storage + make it rx + make it on other thread
                    try Disk.append(data, to: "mineGif.json", in: .documents)
                } catch { print("fail to save gif")}
                
                loading.accept(false)
                done.accept(())
            }
            
            input.bottomButtonTapped
                .subscribe(onNext: { [weak self] in
                    self?.loading.accept(true)
                    if self?.finishedProcess == true, let data = self?.gifData {
                        handleGif(data)
                    }
                }).disposed(by: disposeBag)
            
            input.gifFinished
                .subscribe(onNext: { [weak self] data in
                    let userTapSave = self?.loading.value == true
                    
                    if userTapSave {
                        handleGif(data)
                    } else {
                        self?.finishedProcess = true
                        self?.gifData = data
                    }
                }).disposed(by: disposeBag)
        }
    }
}
