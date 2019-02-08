//
//  OfferViewModel.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

enum OfferType: String {
    case product = "product"
    case item = "item"
}

class OfferViewModel {
    
    private let offer: Offer
    
    init(offer: Offer) {
        self.offer = offer
    }
    
    var id: String { return offer.id }
    var title: String { return offer.name }
    var groupName: String { return offer.groupName }
    var desc: String? { return offer.desc }
    var image: String? { return offer.image }
    
    var price: String? {
        guard let priceValue = offer.price else { return nil }
        return String(format: "%@ R", priceValue.stringValue())
    }
    
    var discountValue: String? {
        guard offer.type == OfferType.product.rawValue else { return nil }
        let value = (offer.discount! * 100).stringValue()
        return String(format: "%@ %%", value)
    }
    var discountAmount: NSAttributedString? {
        guard offer.type == OfferType.product.rawValue else { return nil }
        let amount = (offer.price! * offer.discount!).stringValue()
        let stringAmount = String(format: "%@ R", amount)
        return NSAttributedString(string: stringAmount, attributes: [NSAttributedString.Key.strikethroughStyle : 1])
    }
}
