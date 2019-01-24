//
//  ImageLoadManager.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 11/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit
class ImageLoadManager: Any {
    static var shared = ImageLoadManager()
    private var requestOperations: OperationQueue
    
    init() {
        self.requestOperations = OperationQueue()
        self.requestOperations.maxConcurrentOperationCount = 6
        self.requestOperations.name = "com..ImageDownload"
    }
    
    func downloadImage(withUrl url: String, shouldStore: Bool, completion: @escaping ((_ url: String, _ hashable: UIImage?) -> Swift.Void)) -> Operation? {
        
        if FileManager.default.fileExists(atPath: ImageDownloadOperation.pathForDictionary.appendingPathComponent(url.md5).path) {
            if let responseData = FileManager.default.contents(atPath: ImageDownloadOperation.pathForDictionary.appendingPathComponent(url.md5).path) {
                completion(url, responseData.animatedImageFromData())
            }else {
                completion(url, nil)
            }
            return nil
        }else {
            let downloadOperation = ImageDownloadOperation(urlString: url, shouldStore: shouldStore) {[weak self] (data, _) in
                if self != nil {
                    if let responseData = data {
                        completion(url, responseData.animatedImageFromData())
                    }else {
                        completion(url, nil)
                    }
                }
            }
            downloadOperation.performOperation()
            return downloadOperation
        }
    }
    
}

class ImageCache {
    var images = [String: UIImage]()
    
    init() {
        _ = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification,
                                                   object: nil, queue: OperationQueue.main) { _ in
                                                    self.images.removeAll(keepingCapacity: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    class var sharedCache: ImageCache {
        return ImageCache()
    }
    
    func setImage(image: UIImage, forKey key: String) {
        images[key] = image
    }
    
    func imageForKey(key: String) -> UIImage? {
        return images[key]
    }
}
