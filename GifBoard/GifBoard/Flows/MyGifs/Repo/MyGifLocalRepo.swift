//
//  MyGifLocalRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 03/12/2021.
//

import Foundation
import RxSwift
import Disk

protocol MyGifLocalRepo {
    func getMyGif(index: Int) -> Single<([UIImage], Camera.GifContent)>
}

extension Giff.My.Repo {
    
    final class Local: MyGifLocalRepo {
        
        func getMyGif(index: Int) -> Single<([UIImage], Camera.GifContent)> {
            
            return Single.create { single -> Disposable in
                
                DispatchQueue.global(qos: .background).async {
                    
                    do {
                        let content = try Disk.retrieve("GifIndex\(index)\\Content", from: .documents, as: Camera.GifContent.self)
                        var images = [UIImage]()
                        
                        try (0...content.imagesCount).forEach { imageIndex in
                            let imageExist =  Disk.exists("GifIndex\(index)/\(imageIndex)", in: .documents)
                            
                            if imageExist {
                                let image = try Disk.retrieve("GifIndex\(index)/\(imageIndex)", from: .documents, as: [UIImage].self).first ?? UIImage()
                                images.append(image)
                            }
                        }
                        single(.success((images, content)))
                    } catch let error {
                        single(.error(error))
                    }
                }
                return Disposables.create()
            }
        }
    }
}
