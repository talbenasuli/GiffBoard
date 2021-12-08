//
//  CameraGifContentData.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 04/12/2021.
//

import Foundation

extension Camera {
    
    struct GifContent: Codable {
        var duration: TimeInterval
        var imagesCount: Int
    }
}
