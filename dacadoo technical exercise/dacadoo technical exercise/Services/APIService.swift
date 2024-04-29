//
//  APIService.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import Foundation

private enum APIServiceConstants {
    static let clientID = "NHr5nmnvy4fJA0AtfpReQm_EI2SBnnvPajDObRtmYbY"
    static let baseURL = "https://api.unsplash.com/search/photos"
}

final class APIService {
    
    func fetchImages(for query: String) {
        let urlString = "\(APIServiceConstants.baseURL)?query=\(query)&client_id=\(APIServiceConstants.clientID)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                print(result)
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
