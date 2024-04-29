//
//  ViewController.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

private enum SearchViewControllerConstants {
    static let searchTitle = "Search"
}

class SearchViewController: UIViewController {

    let searchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    
    private func setupUI() {
        title = SearchViewControllerConstants.searchTitle
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

}

// MARK: - UISearchBarDelegate Extension
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
    }
    
}

