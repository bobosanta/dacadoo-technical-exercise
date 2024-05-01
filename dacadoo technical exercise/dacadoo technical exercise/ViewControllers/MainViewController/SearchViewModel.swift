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
    
    var imagesWithDescription = CurrentValueSubject<[ImageWithDescription], Never>([])
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchImages(query: String) async throws {
        let result = await apiService.fetchImagesWithDescription(for: query)
        
        switch result {
        case .success(let images):
            let imagesWithResizedImages = images.map { imageWithDescription in
                let resizedImage = resizeImage(image: imageWithDescription.fullSizeImage, targetWidth: SearchViewModelConstants.targetWidth) ?? imageWithDescription.fullSizeImage
                return ImageWithDescription(imageDescription: imageWithDescription.imageDescription, fullSizeImage: imageWithDescription.fullSizeImage, resizedImage: resizedImage)
            }
            imagesWithDescription.send(imagesWithResizedImages)
        case .failure(let error):
            throw error
        }
    }
    
    // MARK: - Private methods
    private func resizeImages(images: [ImageWithDescription]) -> [UIImage] {
        return images.compactMap { imageWithDescription in
            let resizedImage = resizeImage(image: imageWithDescription.fullSizeImage, targetWidth: SearchViewModelConstants.targetWidth)
            return resizedImage
        }
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
