//
//  CamearaViewModelType.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

extension Camera {
    
    struct ViewModelInput {
        var cameraLongPressBagan = PublishRelay<Void>()
        var cameraLongPressFinished = PublishRelay<Void>()
        var cancelTapped = PublishRelay<Void>()
        var openCamera = PublishRelay<Void>()
        var enableTouch = BehaviorRelay<Bool>(value: false)
    }
    
    struct ViewModelOutput {
        var cameraLayer: Driver<AVCaptureVideoPreviewLayer>
        var enableTouch: Driver<Bool>
        var cancelTapped: Driver<Void>
        var images: Driver<[UIImage]>
        var duration: TimeInterval
        var gifFinished: Driver<Void>
    }
}

protocol CameraViewModelType {
    var input: Camera.ViewModelInput { get }
    var output: Camera.ViewModelOutput { get }
}
