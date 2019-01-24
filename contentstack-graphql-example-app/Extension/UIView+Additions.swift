//
//  UIView+Additions.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 18/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
    
    static var nib : UINib {get}
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        let bundle = Bundle(for: self.self)
        return UINib(nibName: self.nibName, bundle: bundle)
    }
}

extension UIView {
    func  loadNib<T:UIView> () -> T where T : NibLoadableView {
        guard let nib = Bundle.main.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T else {
            fatalError("Could not load nib: \(T.nibName)")
        }
        return nib
    }
}

extension UITableViewCell : ReusableView, NibLoadableView {
    
}
extension UITableViewHeaderFooterView : ReusableView, NibLoadableView {
    
}
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}

extension UICollectionViewCell : ReusableView, NibLoadableView {
    
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}


extension UIView {
    
}

