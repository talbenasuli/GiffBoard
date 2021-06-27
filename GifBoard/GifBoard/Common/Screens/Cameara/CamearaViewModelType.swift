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

protocol CameraViewModelType {
    
    // output
    var cameraLayer: Driver<AVCaptureVideoPreviewLayer> { get }
    var enableTouch: Driver<Bool> { get }
    
    // input
    var cameraLongPressBagan: PublishRelay<Void> { get }
    var cameraLongPressFinished: PublishRelay<Void> { get }
    var cancelTapped: PublishRelay<Void> { get }
    
    func openCamera()
}
