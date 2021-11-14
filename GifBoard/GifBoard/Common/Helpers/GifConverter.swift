//
//  GifConverter.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 28/06/2021.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import ImageIO

protocol GifConverter {
    func createGIF(form images: [UIImage], saveableURL: URL?, loopCount: Int, frameDelay: Double, onFinished: (URL?) -> Void)
}

extension Giff {
    
    final class Converter: GifConverter {
        
        func createGIF(form images: [UIImage], saveableURL: URL? = nil, loopCount: Int = 0, frameDelay: Double = 0.1, onFinished: (URL?) -> Void) {
            
            let destinationURL: URL
            
            if let saveableURL = saveableURL {
                destinationURL = saveableURL
            } else {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                destinationURL = documentsURL!.appendingPathComponent("1.gif")
            }
            
            guard let destinationGIF = CGImageDestinationCreateWithURL(destinationURL as CFURL, kUTTypeGIF, images.count, nil) else {
                onFinished(nil)
                return
            }
            
            let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: loopCount]]
            let gifProperties = [(kCGImagePropertyGIFDictionary as String): [(kCGImagePropertyGIFDelayTime as String): frameDelay]]
            CGImageDestinationSetProperties(destinationGIF, fileProperties as CFDictionary?)
            
            for image in images {
                let cgImage = image.cgImage
                CGImageDestinationAddImage(destinationGIF, cgImage!, gifProperties as CFDictionary?)
            }
            CGImageDestinationFinalize(destinationGIF)
            onFinished(destinationURL)
        }
    }
}
