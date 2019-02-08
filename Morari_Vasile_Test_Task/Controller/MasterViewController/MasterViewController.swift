//
//  MasterViewController.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var offersTableView: UITableView!
    
    private var categoriesBtnController: CategoriesButtonsController!
    private var bannersDataSource: BannersCollectionViewDataSource!
    private var offersDataSource: OffersTableViewDataSource!
    private let client = AWSClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerOfferCells()
        registerBannerCells()
        registerCustomOffersHeader()
        
        setupBannersCollectionView()
        setupCategoriesController()
        setupOfferTableView()
        
        addKeyboardDismissGesture()
    }
    
    private func setupCategoriesController() {
        let controller = self.children.first(where: {$0 is CategoriesButtonsController})
        if let categoriesBtnController = controller as? CategoriesButtonsController {
            categoriesBtnController.delegate = self
        }
    }
    
    private func setupBannersCollectionView() {
        bannersDataSource = BannersCollectionViewDataSource(client: client)
        bannersCollectionView.dataSource = bannersDataSource
        bannersDataSource.loadBanners { apiError in
            self.bannersCollectionView.reloadData()
            self.displayAppropriateAlertIfNeeded(apiError: apiError)
        }
    }
    
    private func setupOfferTableView() {
        offersDataSource = OffersTableViewDataSource(client: client)
        offersTableView.dataSource = offersDataSource
        offersDataSource.loadOffers { (apiError) in
            self.offersTableView.reloadData()
            self.displayAppropriateAlertIfNeeded(apiError: apiError)
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let emptyScreenController = storyboard.instantiateViewController(withIdentifier: Constants.emptyScreenId)
        present(emptyScreenController, animated: true, completion: nil)
    }
}

// MARK: - Helpers
extension MasterViewController {
    private func registerBannerCells() {
        let bannerNib = UINib(nibName: Constants.bannerCellNib, bundle: Bundle.main)
        bannersCollectionView.register(bannerNib, forCellWithReuseIdentifier: Constants.bannerCellId)
    }
    
    private func registerOfferCells() {
        let offerNib = UINib(nibName: Constants.offerCellNib, bundle: Bundle.main)
        offersTableView.register(offerNib, forCellReuseIdentifier: Constants.offerCellId)
    }
    
    private func registerCustomOffersHeader() {
        let headerNib = UINib(nibName: Constants.headerNib, bundle: Bundle.main)
        offersTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.headerId)
    }
    
    private func displayAppropriateAlertIfNeeded(apiError: APIError?) {
        guard let error = apiError else { return }
        let ac = UIAlertController(title: "Error occured", message: error.description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
}

// MARK: UITableViewDelegate
extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerId)
        
        if let offersHeaderView = headerView as? OffersTableViewHeaderView {
            let headerTitle = offersDataSource.offersSections[section].title
            offersHeaderView.setTitle(title: headerTitle)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Удалить", handler: { (action, sourceVIew, success:(Bool) -> Void) in
            success(true)
        })
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - CategoriesButtonsControllerDelegate
extension MasterViewController: CategoriesButtonsControllerDelegate {
    func didSelect(_ category: CategoriesButtonsController.CategoryType) {
        // Executed after one of category buttons is tapped
    }
}

// MARK: - UISearchBarDelegate
extension MasterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

private struct Constants {
    static let bannerCellNib = "BannerCollectionViewCell"
    static let bannerCellId = "BannerCollectionViewCell"
    
    static let offerCellNib = "OfferTableViewCell"
    static let offerCellId = "OfferTableViewCell"
    
    static let headerNib = "OffersTableViewHeaderView"
    static let headerId = "OffersTableViewHeaderView"
    
    static let emptyScreenId = "EmptyScreenControllerId"
}
