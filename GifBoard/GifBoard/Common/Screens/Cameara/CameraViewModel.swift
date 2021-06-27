//
//  CamearaViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

extension Camera {
    
    final class ViewModel: CameraViewModelType {
       
        var cameraLongPressBagan = PublishRelay<Void>()
        var cameraLongPressFinished = PublishRelay<Void>()
        
        private let cameraSessionController = CameraSessionController()
        
        private let _cameraLayer = PublishRelay<AVCaptureVideoPreviewLayer>()
        lazy var cameraLayer = _cameraLayer.asDriver(onErrorDriveWith: .never())
        
        private let _enableTouch = BehaviorRelay<Bool>(value: false)
        lazy var enableTouch = _enableTouch.asDriver(onErrorDriveWith: .never())
        
        var cancelTapped = PublishRelay<Void>()
        
        let disposeBag = DisposeBag()
        
        init() {
            cameraSessionController.delegate = self
            subscribeCameraLongPress()
        }

        func openCamera() {
            cameraSessionController.openCamera()
            cameraSessionController.switchCamera()
        }
    }
}

private extension Camera.ViewModel {
    
    func subscribeCameraLongPress() {

        cameraLongPressBagan
            .asObservable()
            .bind(to: cameraSessionController.rx.startCapturingVideo)
            .disposed(by: disposeBag)
        
        cameraLongPressFinished
            .bind(to: cameraSessionController.rx.stopCapturingVideo)
            .disposed(by: disposeBag)
    }
}

extension Camera.ViewModel: CameraSessionControllerDelegate {
    
    func cameraSessionControllerIsReady(_ controller: CameraSessionController, with layer: AVCaptureVideoPreviewLayer) {
        _enableTouch.accept(true)
        _cameraLayer.accept(layer)
    }
    
    func cameraSessionControllerFailed(_ controller: CameraSessionController, with error: AVError.Code) {
        
    }
    
    func cameraSessionControllerdidFinishProcessing(_ controller: CameraSessionController, image: UIImage) {
        
    }
    
    func cameraSessionContreollerSavedVideoTo(File url: URL) {
        
    }
}
