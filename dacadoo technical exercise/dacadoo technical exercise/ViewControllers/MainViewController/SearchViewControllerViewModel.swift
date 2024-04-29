//
//  SearchViewControllerViewModel.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

class SearchViewControllerViewModel {
    
    private let apiService: APIService?
    
    init(apiService: APIService?) {
        self.apiService = apiService
    }
    
    func fetchImages(query: String) async throws -> [UIImage] {
        return try await apiService?.fetchImages(for: query) ?? []
    }
    
}
