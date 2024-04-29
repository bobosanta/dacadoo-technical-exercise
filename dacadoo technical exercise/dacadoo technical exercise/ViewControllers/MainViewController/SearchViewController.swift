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
    
    @IBOutlet weak var tableView: UITableView!
    
    var images: [UIImage] = []
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCell()
    }
    
    private func registerCell() {
        ImageCell.registerByClassName(tableView: tableView)
    }
    
    private func fetchImages(for query: String) {
        Task {
            do {
                let images = try await viewModel.fetchImages(query: query)
                self.images = images
                
                tableView.reloadData()
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

// MARK: - UITableViewDelegate and Datasource Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.cellReuseIdentifier(), for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }
        
        cell.configure(image: images[indexPath.row])
        
        return cell
    }
}
