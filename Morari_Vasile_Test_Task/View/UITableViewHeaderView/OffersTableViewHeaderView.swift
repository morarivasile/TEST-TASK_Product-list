//
//  OffersTableViewHeaderView.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class OffersTableViewHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
