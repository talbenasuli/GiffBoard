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
import UIKit
import AVFoundation
import Photos
import MobileCoreServices

extension Camera {
    
    final class ViewModel: CameraViewModelType {
        
        var input = ViewModelInput()
        
        private let cameraLayer = PublishRelay<AVCaptureVideoPreviewLayer>()
        private let gifURL = PublishRelay<URL>()
        
        lazy var output = ViewModelOutput(cameraLayer: cameraLayer.asDriver(onErrorDriveWith: .never()),
                                          enableTouch: input.enableTouch.asDriver(onErrorDriveWith: .never()),
                                          cancelTapped: input.cancelTapped.asDriver(onErrorDriveWith: .never()),
                                          gifUrl: gifURL.asDriver(onErrorDriveWith: .never()),
                                          images: finishedSnapshot.asDriver(onErrorDriveWith: .never()),
                                          duration: duration)
        
        private let cameraSessionController = CameraSessionController()
        private let gifConverter: GifConverter
        private var userLongPress = true
        
        let disposeBag = DisposeBag()
        
        private var capturedImages = [UIImage]()
        private var finishedSnapshot = BehaviorRelay<[UIImage]>(value: [])
        private var timer: Timer?
        private var duration = 0.0
        private var startTime: TimeInterval?
        private lazy var takeShotWorkItem =  DispatchWorkItem(block: { })
        
        init(gifConverter: GifConverter = Giff.Converter()) {
            self.gifConverter = gifConverter
            cameraSessionController.delegate = self
            cameraSessionController.switchCamera()
            subscribeCameraLongPress()
        }

        func openCamera() {
            cameraSessionController.openCamera()
        }
    }
}

private extension Camera.ViewModel {
    
    func subscribeCameraLongPress() {
        
        input.openCamera
            .bind(to: cameraSessionController.rx.openCamera)
            .disposed(by: disposeBag)

        input.cameraLongPressBagan
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.takeShotWorkItem =  DispatchWorkItem { [weak self] in
                    guard let self = self else { return }
                    self.capturedImages = []
                    DispatchQueue.global(qos: .background).async { [weak self] in
                        guard let self = self else { return }
                        while(self.userLongPress && self.capturedImages.count <= 60) {
                            self.cameraSessionController.takeShot()
                        }
                    }
                }
                self.takeShotWorkItem.perform()
                self.startTime = NSDate.timeIntervalSinceReferenceDate
                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.countTime), userInfo: nil, repeats: true)
            }).disposed(by: disposeBag)
        
        input.cameraLongPressFinished
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.userLongPress = false
                self.takeShotWorkItem.cancel()
                self.finishedSnapshot.accept(self.capturedImages)
                
                DispatchQueue.global().async {
                    self.gifConverter.createGIF(form: self.capturedImages, saveableURL: nil, loopCount: 1, frameDelay: 0, onFinished: { [weak self] url in
                        if let url = url {
                            print("finished!!!!!!!!!!!!!!!!!!!")
                            self?.gifURL.accept(url)
                            let data: NSData = NSData(contentsOf: url)!
                            UIPasteboard.general.setData(data as Data, forPasteboardType: "com.compuserve.gif")
                        }
                    })
                }
                
            }).disposed(by: disposeBag)
    }
    
    @objc func countTime() {
        guard let startTime = startTime else { return }
        duration = NSDate.timeIntervalSinceReferenceDate - startTime
    }
    
    func finishTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension Camera.ViewModel: CameraSessionControllerDelegate {
    
    func cameraSessionControllerIsReady(_ controller: CameraSessionController, with layer: AVCaptureVideoPreviewLayer) {
        input.enableTouch.accept(true)
        cameraLayer.accept(layer)
    }
    
    func cameraSessionContreollerSavedVideoTo(File url: URL) { }
    
    func cameraSessionControllerFailed(_ controller: CameraSessionController, with error: AVError.Code) {}
    
    func cameraSessionControllerdidFinishProcessing(_ controller: CameraSessionController, image: UIImage) {
        capturedImages.append(image)
        print(capturedImages.count)
    }
}