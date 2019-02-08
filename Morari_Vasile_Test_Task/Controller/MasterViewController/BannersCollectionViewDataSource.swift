//
//  BannersCollectionViewDataSource.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/5/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

final class BannersCollectionViewDataSource: NSObject {
    
    private let client: AWSClient!
    private var banners: [Banner] = []
    
    init(client: AWSClient) {
        self.client = client
    }
    
    func loadBanners(completion: @escaping (APIError?) -> ()) {
        client.getData(with: AWSFiles.banners) { (result: Result<[Banner], APIError>) in
            var apiError: APIError?
            if case .success(let banners) = result {
                self.banners = banners
            } else if case .failure(let error) = result {
                apiError = error
            }
            completion(apiError)
        }
    }
}

extension BannersCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.bannerCellId, for: indexPath)
        
        if let bannerCell = cell as? BannerCollectionViewCell {
            bannerCell.setup(with: banners[indexPath.row])
        }
        return cell
    }
}

private struct Constants {
    static let bannerCellNib = "BannerCollectionViewCell"
    static let bannerCellId = "BannerCollectionViewCell"
}
