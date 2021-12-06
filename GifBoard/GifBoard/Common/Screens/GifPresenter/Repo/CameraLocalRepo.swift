//
//  CameraLocalRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 04/12/2021.
//

import UIKit
import Disk
import RxSwift

protocol CameraLocalRepo {
    func save(images: [UIImage], into fileName: String, andWith contentData: Camera.GifContent) -> Single<Void>
}

extension Camera.Repo {
    
    final class Local: CameraLocalRepo {
        
        func save(images: [UIImage], into fileName: String, andWith contentData: Camera.GifContent) -> Single<Void> {
            return Single.create { single -> Disposable in
                
                DispatchQueue.global(qos: .background).async {
                    do {
                        try Disk.save(images, to: .documents, as: fileName)
                        try Disk.save(contentData, to: .documents, as: "\(fileName)\\Content")
                        single(.success(()))
                    } catch let error {
                        single(.error(error))
                    }
                }
                
                return Disposables.create()
            }
          
        }
    }
}
