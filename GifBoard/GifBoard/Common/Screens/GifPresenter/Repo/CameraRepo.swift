//
//  CameraRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 04/12/2021.
//

import UIKit
import RxSwift

extension Camera {
    enum Repo { }
}

protocol CameraRepo {
    func save(images: [UIImage], into fileName: String, andWith contentData: Camera.GifContent) -> Single<Void>
}

extension Camera.Repo {
    
    final class Base: CameraRepo {
        
        let localRepo: CameraLocalRepo
        
        init(localRepo: CameraLocalRepo) {
            self.localRepo = localRepo
        }
        
        func save(images: [UIImage], into fileName: String, andWith contentData: Camera.GifContent) -> Single<Void> {
            return localRepo.save(images: images, into: fileName, andWith: contentData)
        }
    }
}
