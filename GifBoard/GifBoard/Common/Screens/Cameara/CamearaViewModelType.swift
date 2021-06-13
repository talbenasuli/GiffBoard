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
    
    var cameraLayer: Driver<AVCaptureVideoPreviewLayer> { get }
    
    func openCamera()
}
