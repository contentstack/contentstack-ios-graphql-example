//
//  Data+Additions.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 11/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
import CoreGraphics

extension Data {
    func contentTypeForImage() -> String?{
        var c: UInt8 = 0
        
        self.copyBytes(to: &c, count: 1)
        switch (c) {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }
    
    func animatedImageFromData() -> UIImage? {
        var animatedImage: UIImage?
        let source: CGImageSource = CGImageSourceCreateWithData(self as CFData, nil)!
        let count: size_t = CGImageSourceGetCount(source)
        let EPS: Float = 1e-6
        if (count <= 1) {
            animatedImage = UIImage(data: self)
        }else {
            var imageArray: [UIImage] = [UIImage]()
            var duration: TimeInterval = 0.0
            
            for size: Int in 0 ..< count {
                let image: CGImage = CGImageSourceCreateImageAtIndex(source, size, nil)!
                let imagesourceProperty = CGImageSourceCopyPropertiesAtIndex(source, size, nil)
                let key = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
                if  let value = CFDictionaryGetValue(imagesourceProperty, key) {
                    let unclampedKey = Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()
                    let unclampedPointer: UnsafeRawPointer? = CFDictionaryGetValue(unsafeBitCast(value, to: CFDictionary.self), unclampedKey)
                    if let delayVal = convertToDelay(unclampedPointer), delayVal >= EPS {
                        duration += TimeInterval(delayVal)
                    }else {
                        let unclampedKey = Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()
                        let unclampedPointer: UnsafeRawPointer? = CFDictionaryGetValue(unsafeBitCast(value, to: CFDictionary.self), unclampedKey)
                        if let delayVal = convertToDelay(unclampedPointer), delayVal >= EPS {
                            duration += TimeInterval(delayVal)
                        }
                    }
                }
                imageArray.append(UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up))
            }
            animatedImage = UIImage.animatedImage(with: imageArray as [UIImage], duration: duration)
        }
        return animatedImage
    }
    
    func compressImage() -> Data {
        // Reducing file size to a 10th
        let source: CGImageSource = CGImageSourceCreateWithData(self as CFData, nil)!
        let count: size_t = CGImageSourceGetCount(source)
        if (count <= 1) {
            if let image: UIImage = UIImage(data: self) {
                var actualHeight: CGFloat = image.size.height
                var actualWidth: CGFloat = image.size.width
                let maxHeight: CGFloat = 1136.0
                let maxWidth: CGFloat = 640.0
                var imgRatio: CGFloat = actualWidth/actualHeight
                let maxRatio: CGFloat = maxWidth/maxHeight
                
                if (actualHeight > maxHeight || actualWidth > maxWidth){
                    if(imgRatio < maxRatio){
                        //adjust width according to maxHeight
                        imgRatio = maxHeight / actualHeight
                        actualWidth = imgRatio * actualWidth
                        actualHeight = maxHeight
                    }
                    else if(imgRatio > maxRatio){
                        //adjust height according to maxWidth
                        imgRatio = maxWidth / actualWidth
                        actualHeight = imgRatio * actualHeight
                        actualWidth = maxWidth
                    }
                    else{
                        actualHeight = maxHeight
                        actualWidth = maxWidth
                    }
                }
                
                let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
                UIGraphicsBeginImageContext(rect.size)
                image.draw(in: rect)
                
                let img = UIGraphicsGetImageFromCurrentImageContext()
                UIColor.red.set()
                UIRectFill(CGRect(x: 0.0, y: 0.0, width: rect.size.width,height: rect.size.height)); //fill the bitmap context
                
                let imageData = img?.pngData()
                UIGraphicsEndImageContext()
                return imageData!
                
            }
        }
        return self
    }
    
    fileprivate func convertToDelay(_ pointer: UnsafeRawPointer?) -> Float? {
        if pointer == nil {
            return nil
        }
        let value = unsafeBitCast(pointer, to: AnyObject.self)
        return value.floatValue
    }
}
