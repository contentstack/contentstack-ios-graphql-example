//
//  UIImageView+Additions.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 11/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit
var operations: UInt8 = 0
var loadUrlString: UInt8 = 0
var openUrlString: UInt8 = 0
var event: UInt8 = 0

protocol DownloadImage: class {}
protocol TapGestureMange: class {}

extension TapGestureMange where Self: UIView {
    
    var onClickEvent: ((_ urlString: String) -> Swift.Void)? {
        set {
            objc_setAssociatedObject(self, &event, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &event) as? ((_ urlString: String) -> Swift.Void)
        }
    }
    
    var deeplinkNavigatorPath: String? {
        set {
            objc_setAssociatedObject(self, &openUrlString, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &openUrlString) as? String
        }
    }
    
//    func addTapGesture(urlString: String?, onClick: ((_ urlString: String) -> Swift.Void)? = nil) {
//        self.gestureRecognizers                 = nil
//        self.onClickEvent                       = onClick
//        if let url = urlString {
//            self.deeplinkNavigatorPath              = url
//            self.isUserInteractionEnabled           = true
//            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.performDeeplink))
//            self.addGestureRecognizer(tapGesture)
//        }
//    }
    
    //    func addTapGesture(urlString: String?) {
    //        self.gestureRecognizers                 = nil
    //        if let url = urlString {
    //            self.deeplinkNavigatorPath              = url
    //            self.isUserInteractionEnabled           = true
    //            let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.performDeeplink))
    //            self.addGestureRecognizer(tapGesture)
    //        }
    //    }
}

extension DownloadImage where Self: UIImageView {
    var loadingString: String? {
        set {
            objc_setAssociatedObject(self, &loadUrlString, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &loadUrlString) as? String
        }
    }
    
    func loadImage(urlString: String?, shouldReload: Bool = false, completion: ((_ image: UIImage?) -> Swift.Void)? = nil)  {
        if urlString != nil {
            if urlString?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
                return
            }
            self.loadingString = urlString!.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: " ").inverted)!
            _ = ImageLoadManager.shared.downloadImage(withUrl: self.loadingString!, shouldStore: !shouldReload) {[weak self] (url, image) in
                DispatchQueue.main.async {
                    if let slf = self, let img = image {
                        if slf.loadingString == url {
                            slf.image = img
                            if let cmp = completion{
                                cmp(image)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func cancelOperation (_ url: String)  {
        var operationDict = self.getOperationDict()
        if let operation: Operation = operationDict[url] as? Operation {
            operation.cancel()
            operationDict[url] = nil
        }
        objc_setAssociatedObject(self, &operations, operationDict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func setOperation (_ operation: Operation, for key: String) {
        var operationDict = self.getOperationDict()
        operationDict[key] = operation
        objc_setAssociatedObject(self, &operations, operationDict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func getOperationDict () -> [AnyHashable: Operation?] {
        if let operationDictionary = objc_getAssociatedObject(self, &operations) as? [AnyHashable: Operation] {
            return operationDictionary
        }else {
            let operationDictionary = [AnyHashable: Operation?]()
            objc_setAssociatedObject(self, &operations, operationDictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return operationDictionary
        }
    }
}

extension UIImageView: DownloadImage {
    
}
//
//extension UIView: TapGestureMange {
//    @objc func performDeeplink () {
//        if let linkPath = self.deeplinkNavigatorPath {
//            if let linkURL = URL(string: linkPath) {
//                if let eventClick = self.onClickEvent {
//                    eventClick(linkPath)
//                }
//                linkURL.performDeepLinking(openStyle: "present")
//            }
//        }
//    }
//}

