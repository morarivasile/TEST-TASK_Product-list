//
//  Offer.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

struct Offer: Decodable {
    let id: String
    let name: String
    let groupName: String
    let type: String
    let desc: String?
    let image: String?
    let price: Float?
    let discount: Float?
}
