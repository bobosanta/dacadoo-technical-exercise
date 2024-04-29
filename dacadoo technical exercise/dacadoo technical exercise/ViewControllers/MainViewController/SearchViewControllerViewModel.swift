//
//  SearchViewControllerViewModel.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import Foundation

class SearchViewControllerViewModel {
    
    private let apiService: APIService?
    
    init(apiService: APIService?) {
        self.apiService = apiService
    }
    
    func fetchImages(query: String) {
        apiService?.fetchImages(for: query)
    }
    
}
