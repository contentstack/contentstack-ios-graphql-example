//
//  ProductCell.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 03/12/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
