//
//  ProductListViewController.swift
//  contentstack-graphql-example-app
//
//  Created by Uttam Ukkoji on 02/01/19.
//  Copyright © 2019 Contentstack. All rights reserved.
//

import UIKit
import Apollo
import SVPullToRefresh
class ProductListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let refresh : UIRefreshControl = UIRefreshControl(frame: CGRect.zero)
    var productArray: [ProductsQuery.Data.AllProduct.Item] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.refreshControl = refresh
        self.collectionView.addInfiniteScrolling {[weak self] in
            guard let slf = self else {
                return
            }
            slf.getProductList(skip: slf.productArray.count)
        }
        self.refresh.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        self.refresh.beginRefreshing()
        reloadData()
        
        self.title = "Products"
        if let flowdelegate = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (UIScreen.main.bounds.width - 30)/2
            flowdelegate.itemSize = CGSize(width: width, height: width  + 40)
        }
        collectionView.registerNib(ProductCell.self)
    }
    
    @objc
    func reloadData()  {
        self.collectionView.showsInfiniteScrolling = false
        self.getProductList(skip: 0)
    }
    
    func getProductList(skip: Int)  {
        AppDelegate.share.contentstackService.graphQLClient.fetch(query: ProductsQuery(skip: skip, limit: 5), cachePolicy: CachePolicy.fetchIgnoringCacheData, queue: DispatchQueue.main, resultHandler: {[weak self]  result, error in
            guard let slf = self else {
                return
            }
            if skip == 0 {
                var indexPaths : [IndexPath] = []
                for i in 0..<slf.productArray.count {
                    indexPaths.append(IndexPath(item: i, section: 0))
                }
                slf.productArray.removeAll()
                slf.collectionView.deleteItems(at: indexPaths)
                slf.refresh.endRefreshing()
            }
            guard let resultS = result, let data = resultS.data, let products = data.allProduct?.items else {
                return
            }
            var indexPaths : [IndexPath] = []
            var index = slf.productArray.count
            for product in products {
                indexPaths.append(IndexPath(item: (index), section: 0))
                index += 1
                slf.productArray.append(product!)
            }
            slf.collectionView.insertItems(at: indexPaths)
            
            slf.collectionView.showsInfiniteScrolling = true
            slf.collectionView.infiniteScrollingView.stopAnimating()
        })
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ProductCell
        let product = productArray[indexPath.row]
        cell.productName.text = product.title
        cell.productPrice.text = "\(String(describing: product.price!))"
        if let featuredIMG = product.featuredImage?.first {
            cell.productImage.loadImage(urlString: featuredIMG?.fragments.asset.url)
        }
        return cell
    }
}
