//
//  OfferTableViewCell.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDiscountAmountLabel: UILabel!
    @IBOutlet weak var productDiscountLabel: UILabel!
    @IBOutlet weak var addToBagButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }
    
    func setup(with offer: OfferViewModel) {
        productDescLabel.text = offer.desc
        productNameLabel.text = offer.title
        productPriceLabel.text = offer.price
        productDiscountLabel.text = offer.discountValue
        productDiscountAmountLabel.attributedText = offer.discountAmount
        
        if let image = offer.image {
            productImageView.loadImageUsingURLString(urlString: image)
        }
    }
    
    func roundCorners() {
        productImageView.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 6
        addToBagButton.layer.cornerRadius = 12
        productDiscountLabel.layer.cornerRadius = 8
    }
}
