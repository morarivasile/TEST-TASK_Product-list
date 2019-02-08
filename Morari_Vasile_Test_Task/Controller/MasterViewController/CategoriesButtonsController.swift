//
//  CategoriesButtonsController.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/5/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

protocol CategoriesButtonsControllerDelegate: class {
    func didSelect(_ category: CategoriesButtonsController.CategoryType)
}

final class CategoriesButtonsController: UIViewController {
    @IBOutlet weak var top10Button: RoundedSelectableButton!
    @IBOutlet weak var shopsButton: RoundedSelectableButton!
    @IBOutlet weak var productsButton: RoundedSelectableButton!
    
    private var buttonsDictionary: [RoundedSelectableButton: CategoryType] = [:]
    
    private(set) var selectedCategory: CategoryType?
    weak var delegate: CategoriesButtonsControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsDictionary = [top10Button: .top10,
                             shopsButton: .shops,
                             productsButton: .products]
    }
    
    @IBAction func onButtonTapped(_ sender: RoundedSelectableButton) {
        if let category = buttonsDictionary[sender] {
            if selectedCategory != category {
                deselectButtons(except: sender)
                
                selectedCategory = category
                delegate?.didSelect(category)
                
                NSLog("Category Button tapped: \(category)")
            } else {
                selectedCategory = nil
            }
        }
    }
    
    private func deselectButtons(except sender: RoundedSelectableButton) {
        for button in buttonsDictionary.keys where button != sender {
            button.isOn = false
        }
    }
    
    enum CategoryType {
        case top10
        case shops
        case products
    }
}
