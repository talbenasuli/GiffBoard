//
//  ImageExtensions.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/12/2021.
//

import UIKit

extension UIImage {

    func thumbnail(size: CGFloat) -> UIImage {
        let size = CGSize(width: size, height: size)

        // Define rect for thumbnail
        let scale = max(size.width/size.width, size.height/size.height)
        let width = size.width * scale
        let height = size.height * scale
        let x = (size.width - width) / CGFloat(2)
        let y = (size.height - height) / CGFloat(2)
        let thumbnailRect = CGRect.init(x: x, y: y, width: width, height: height)

        // Generate thumbnail from image
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: thumbnailRect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
}
