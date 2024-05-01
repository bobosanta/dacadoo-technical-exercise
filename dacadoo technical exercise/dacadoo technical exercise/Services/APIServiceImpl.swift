//
//  APIService.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

struct ImageWithDescription {
    let imageDescription: String
    let image: UIImage
}

private enum APIServiceConstants {
    static let clientID = "NHr5nmnvy4fJA0AtfpReQm_EI2SBnnvPajDObRtmYbY"
    static let baseURL = "https://api.unsplash.com/search/photos"
    static let httpMethodGET = "GET"
}

enum APIServiceError: Error {
    case invalidURL
    case networkError(_ error: Error)
    case unknownError
}

final class APIServiceImpl: APIService {

    func fetchImages(for query: String) async -> Result<[ImageWithDescription], Error> {
        do {
            let urlString = "\(APIServiceConstants.baseURL)?query=\(query)&client_id=\(APIServiceConstants.clientID)"
            
            guard let url = URL(string: urlString) else {
                throw APIServiceError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = APIServiceConstants.httpMethodGET
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(UnsplashResponse.self, from: data)
            let images = try await downloadImages(from: result.results)
            
            return .success(images)
        } catch {
            return .failure(error)
        }
    }
    
    private func downloadImages(from results: [UnsplashPhoto]) async throws -> [ImageWithDescription] {
        var images: [ImageWithDescription] = []
        
        for photo in results {
            guard let url = URL(string: photo.urls.regular) else {
                print("Invalid image URL")
                continue
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    let imageWithDescription = ImageWithDescription(imageDescription: photo.description ?? "", image: image)
                    images.append(imageWithDescription)
                }
            } catch {
                throw APIServiceError.networkError(error)
            }
        }
        
        return images
    }
}
