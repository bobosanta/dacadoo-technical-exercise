//
//  SearchViewModel.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import Combine
import UIKit

private enum SearchViewModelConstants {
    static let targetWidth = CGFloat(300)
}

class SearchViewModel {
    
    private let apiService: APIService
    
    var images = CurrentValueSubject<[UIImage], Never>([])
    var imagesWithDescription: [ImageWithDescription] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchImages(query: String) async throws {
        let result = await apiService.fetchImages(for: query)
        
        switch result {
        case .success(let images):
            self.imagesWithDescription = images
            self.images.send(resizeImages(images: images))
        case .failure(let error):
            throw error
        }
    }
    
    // MARK: - Private methods
    private func resizeImages(images: [ImageWithDescription]) -> [UIImage] {
        var resizedImages: [UIImage] = []
        
        for imageWithDescription in images {
            if let resizedImage = resizeImage(image: imageWithDescription.image, targetWidth: SearchViewModelConstants.targetWidth) {
                resizedImages.append(resizedImage)
            }
        }
        
        return resizedImages
    }
    
    private func resizeImage(image: UIImage, targetWidth: CGFloat) -> UIImage? {
        let scale = targetWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: targetWidth, height: newHeight), false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        image.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: newHeight))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
