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
                
                var content: Camera.GifContent?
                do {
                    content = try Disk.retrieve("GifIndex\(index)\\Content", from: .documents, as: Camera.GifContent.self)
                } catch { }
                
                guard let content = content else {
                    return Disposables.create()
                }

                let dispatchGroup = DispatchGroup()
                
                var images = [UIImage]()
                
                (0...content.imagesCount).forEach { imageIndex in
                    dispatchGroup.enter()
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        do {
                            let image = try Disk.retrieve("GifIndex\(index)/\(imageIndex)", from: .documents, as: [UIImage].self).first ?? UIImage()
                            images.append(image)
                            dispatchGroup.leave()
                        } catch {
                            dispatchGroup.leave()
                        }
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    single(.success((images, content)))
                }
                return Disposables.create()
            }
        }
    }
}
