//
//  ViewController.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import Combine
import UIKit

private enum SearchViewControllerConstants {
    static let searchTitle = "Search"
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    private let viewModel = SearchViewModel(apiService: APIServiceImpl())
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupUI()
    }

    // MARK: - Private methods
    private func setupBindings() {
        viewModel.imagesWithDescription
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
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
}

// MARK: - UISearchBarDelegate Extension
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        Task {
            try await viewModel.fetchImages(query: text)
        }
    }
}

// MARK: - UITableViewDelegate and Datasource Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imagesWithDescription.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.cellReuseIdentifier(), for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }
        
        cell.configure(image: viewModel.imagesWithDescription.value[indexPath.row].resizedImage, accesibilityLabel: viewModel.imagesWithDescription.value[indexPath.row].imageDescription)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController(viewModel: DetailsViewModel(image: viewModel.imagesWithDescription.value[indexPath.row].fullSizeImage))
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
