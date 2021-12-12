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
        
        private let dispatchQueue = DispatchQueue(label: "com.images", qos: .background, attributes: .concurrent)
        
        func save(images: [UIImage], into fileName: String, andWith contentData: Camera.GifContent) -> Single<Void> {
            return Single.create { single -> Disposable in
                
                let dispatchGroup = DispatchGroup()
                dispatchGroup.enter()
                
                for (index,image) in images.enumerated() {
                    dispatchGroup.enter()
                    self.dispatchQueue.async {
                        do {
                            try Disk.append(image, to: "\(fileName)/\(index)", in: .documents)
                            dispatchGroup.leave()
                        } catch {
                            dispatchGroup.leave()
                        }
                    }
                }
                
                do {
                    try Disk.save(contentData, to: .documents, as: "\(fileName)\\Content")
                    dispatchGroup.leave()
                } catch {
                    dispatchGroup.leave()
                }
                
                dispatchGroup.notify(queue: .main) {
                    single(.success(()))
                }
                
                return Disposables.create()
            }
          
        }
    }
}
