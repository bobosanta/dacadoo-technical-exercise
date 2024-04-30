//
//  APIService.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

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

    func fetchImages(for query: String) async -> Result<[UIImage], Error> {
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
    
    func downloadImages(from results: [UnsplashPhoto]) async throws -> [UIImage] {
        var images: [UIImage] = []
        
        for photo in results {
            guard let url = URL(string: photo.urls.regular) else {
                print("Invalid image URL")
                continue
            }
            
            do {
                let imageData = try await URLSession.shared.data(from: url).0
                if let image = UIImage(data: imageData) {
                    images.append(image)
                }
            } catch {
                throw APIServiceError.networkError(error)
            }
        }
        
        return images
    }
}