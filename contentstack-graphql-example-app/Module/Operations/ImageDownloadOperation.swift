//
//  ImageDownloadOperation.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 11/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
class ImageDownloadOperation: Operation {
    
    private var _executing          = false
    private var _finished           = false
    private var urlString: String
    private var shouldStore: Bool
    private var downlodTask: URLSessionDownloadTask?
    
    private var completion: ((_ hashable: Data?, _ error: Error?) -> Swift.Void)
    
    init(urlString: String, shouldStore: Bool, completion: @escaping ((_ hashable: Data?, _ error: Error?) -> Swift.Void)) {
        self.urlString      = urlString
        self.completion     = completion
        self.shouldStore    = shouldStore
        super.init()
    }
    
    override internal(set) var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    override internal(set) var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    static var pathForDictionary: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.count-1].appendingPathComponent("ImageStore")
    }()
    
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        
        isExecuting = true
        self.main()
    }
    
    private func performCompletion (data: Data?, error: Error?) {
        self.completion(data,error)
        self.isExecuting = false
        self.isFinished = true
        self.downlodTask = nil
    }
    
    func performOperation() {
        let configuration   = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        let session         = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        self.downlodTask    = session.downloadTask(with: URL(string: self.urlString)!)
        self.downlodTask!.resume()
    }
    
    override func main() {
        performOperation()
    }
    
    override func cancel() {
        super.cancel()
        if let task = self.downlodTask {
            task.cancel()
            self.downlodTask = nil
        }
        self.isExecuting = false
        self.isFinished = true
    }
    
    deinit {

    }
}

extension ImageDownloadOperation: URLSessionDelegate, URLSessionDownloadDelegate, URLSessionTaskDelegate {
    @available(iOS 7.0, *)
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var data: Data?
        if var compressData = self.getDataFromDisk(location: location) {
            if self.shouldStore {
                compressData = compressData.compressImage()
                if !FileManager.default.fileExists(atPath: ImageDownloadOperation.pathForDictionary.path) {
                    do {
                        try FileManager.default.createDirectory(atPath: ImageDownloadOperation.pathForDictionary.path, withIntermediateDirectories: true, attributes: nil)
                    }catch let error {

                    }
                }
                let filePath = ImageDownloadOperation.pathForDictionary.appendingPathComponent(self.urlString.md5)
                FileManager.default.createFile(atPath: filePath.path, contents: compressData, attributes: nil)
            }
            data = compressData
        }
        self.performCompletion(data: data, error: nil)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        self.performCompletion(data: nil, error: error)
    }
    
    func getDataFromDisk(location: URL) -> Data? {
        
        var imageData: Data?
        
        do {
            imageData = try Data(contentsOf: location, options: Data.ReadingOptions.dataReadingMapped)
        }catch {
            
        }
        
        if (imageData != nil) {
            return imageData
        }
        return nil
    }
    
}
