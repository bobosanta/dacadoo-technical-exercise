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
    
    private let viewModel = SearchViewControllerViewModel(apiService: APIService())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    
    // MARK: - Private methods
    private func setupUI() {
        title = SearchViewControllerConstants.searchTitle
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func fetchImages(for query: String) {
        Task {
            do {
                let images = try await viewModel.fetchImages(query: query)

                print(images)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UISearchBarDelegate Extension
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        fetchImages(for: text)
    }
}

