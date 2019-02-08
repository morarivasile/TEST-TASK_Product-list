//
//  BannerCollectionViewCell.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/5/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var customMaskView: UIView!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cornerRadius: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
        addShadow()
    }
    
    func setup(with banner: Banner) {
        titleLabel.text = banner.title
        subtitleLabel.text = banner.desc
        if let imageURL = banner.image {
            imageVIew.loadImageUsingURLString(urlString: imageURL)
        }
    }
    
    func roundCorners() {
        let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: imageVIew.frame, byRoundingCorners: .allCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = imageVIew.frame
        maskLayer.path = path.cgPath
        customMaskView.layer.mask = maskLayer
    }
    
    func addShadow() {
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 3)
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOpacity = 0.3
    }
}

extension UIImageView {
    func loadImageUsingURLString(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }.resume()
    }
}
