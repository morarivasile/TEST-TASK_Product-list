//
//  EmptyViewController.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

final class EmptyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func onViewTap() {
        dismiss(animated: true, completion: nil)
    }
}
