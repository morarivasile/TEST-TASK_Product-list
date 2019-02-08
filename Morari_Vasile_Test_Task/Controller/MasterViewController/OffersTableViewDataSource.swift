//
//  OffersTableViewDataSource.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

final class OffersSection {
    var offers: [OfferViewModel] = []
    var title: String
    
    init(offers: [OfferViewModel], title: String) {
        self.offers = offers
        self.title = title
    }
}

final class OffersTableViewDataSource: NSObject {
    
    private(set) var offersSections: [OffersSection] = []
    private let client: AWSClient!
    
    init(client: AWSClient) {
        self.client = client
    }
    
    func loadOffers(completion: @escaping (APIError?) -> ()) {
        client.getData(with: AWSFiles.offers) { (result: Result<[Offer], APIError>) in
            var apiError: APIError?
            if case .success(let offers) = result {
                let offerViewModels = offers.map { OfferViewModel(offer: $0) }
                self.distributeOffers(offers: offerViewModels)
            } else if case .failure(let error) = result {
                apiError = error
            }
            completion(apiError)
        }
    }
    
    private func distributeOffers(offers: [OfferViewModel]) {
        let grouppedOffers = Dictionary(grouping: offers) { $0.groupName }
        offersSections = grouppedOffers.map { OffersSection(offers: $1, title: $0) }
    }
}

extension OffersTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return offersSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersSections[section].offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.offerCellId, for: indexPath)
        
        if let offerCell = cell as? OfferTableViewCell {
            let offer = offersSections[indexPath.section].offers[indexPath.row]
            offerCell.setup(with: offer)
        }
        
        return cell
    }
}

private struct Constants {
    static let offerCellNib = "OfferTableViewCell"
    static let offerCellId = "OfferTableViewCell"
}
