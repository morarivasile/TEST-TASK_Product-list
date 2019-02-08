//
//  SnappingFlowLayout.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/5/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class SnappingFlowLayout: UICollectionViewFlowLayout {
    
    private var isFirstSetupDone = false
    
    override func prepare() {
        super.prepare()
        if !isFirstSetupDone {
            setup()
            isFirstSetupDone = true
        }
    }
    
    private func setup() {
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        itemSize = CGSize(width: 220, height: 150)
        collectionView!.decelerationRate = .fast
        sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let layoutAttributes = layoutAttributesForElements(in: collectionView!.bounds)
        let centerOffset = collectionView!.bounds.size.width / 2
        let offsetWithCenter = proposedContentOffset.x + centerOffset
        
        let closestAttribute = layoutAttributes!
            .sorted { abs($0.center.x - offsetWithCenter) < abs($1.center.x - offsetWithCenter) }
            .first ?? UICollectionViewLayoutAttributes()
        
        return CGPoint(x: closestAttribute.center.x - centerOffset, y: 0)
    }
}
