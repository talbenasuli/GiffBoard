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

        private let cameraSessionController = CameraSessionController()
        
        private let _cameraLayer = PublishRelay<AVCaptureVideoPreviewLayer>()
        lazy var cameraLayer = _cameraLayer.asDriver(onErrorDriveWith: .never())
        
        init() {
            cameraSessionController.delegate = self
        }

        func openCamera() {
            cameraSessionController.openCamera()
            cameraSessionController.switchCamera()
        }
    }
}

extension Camera.ViewModel: CameraSessionControllerDelegate {
    
    func cameraSessionControllerIsReady(_ controller: CameraSessionController, with layer: AVCaptureVideoPreviewLayer) {
        _cameraLayer.accept(layer)
    }
    
    func cameraSessionControllerFailed(_ controller: CameraSessionController, with error: AVError.Code) {
        
    }
    
    func cameraSessionControllerdidFinishProcessing(_ controller: CameraSessionController, image: UIImage) {
        
    }
    
    func cameraSessionContreollerSavedVideoTo(File url: URL) {
        
    }
}
