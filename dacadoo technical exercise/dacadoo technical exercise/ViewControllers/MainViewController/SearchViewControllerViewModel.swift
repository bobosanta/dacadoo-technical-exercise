//
//  SearchViewControllerViewModel.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

class SearchViewControllerViewModel {
    
    private let apiService: APIServiceImpl?
    
    init(apiService: APIServiceImpl?) {
        self.apiService = apiService
    }
    
    func fetchImages(query: String) async throws -> [UIImage] {
        do {
            let result = await apiService?.fetchImages(for: query) ?? .failure(APIServiceError.unknownError)
            
            switch result {
            case .success(let images):
                return images
            case .failure(let error):
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func resizeImage(image: UIImage, targetWidth: CGFloat) -> UIImage? {
        let scale = targetWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: targetWidth, height: newHeight), false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        image.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: newHeight))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
