//
//  RX+CameraSessionController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 15/06/2021.
//

import RxSwift
import RxCocoa

extension Reactive where Base == CameraSessionController {
    
    var takeShot: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.takeShot()
        }
    }
    
    var openCamera: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.openCamera()
        }
    }
    
    var switchCamera: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.switchCamera()
        }
    }
    
    var startCapturingVideo: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.startCapturingVideo()
        }
    }
    
    var stopCapturingVideo: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.stopCapturingVideo()
        }
    }
}

