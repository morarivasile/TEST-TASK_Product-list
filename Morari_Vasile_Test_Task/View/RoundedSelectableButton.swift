//
//  RoundedSelectableButton.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class RoundedSelectableButton: UIButton {
    
    @IBInspectable var activeTintColor: UIColor = .blue
    @IBInspectable var inactiveTintColor: UIColor = .lightGray
    
    @IBInspectable var isOn: Bool = false {
        didSet {
            onStateChange()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        onStateChange()
        layer.cornerRadius = frame.size.height / 2
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func onStateChange() {
        layer.borderColor = isOn ? activeTintColor.cgColor : UIColor.clear.cgColor
        backgroundColor = isOn ? activeTintColor.withAlphaComponent(0.02) : .white
        let titleColor: UIColor = isOn ? activeTintColor : inactiveTintColor
        setTitleColor(titleColor, for: .normal)
        layer.borderWidth = isOn ? 1.0 : 0.0
    }
    
    @objc private func buttonPressed() {
        isOn = !isOn
    }
}
