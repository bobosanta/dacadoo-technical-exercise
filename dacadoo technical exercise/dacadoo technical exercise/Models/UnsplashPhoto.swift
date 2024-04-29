//
//  UnsplashPhoto.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let description: String?
    let urls: PhotoUrls
}

struct PhotoUrls: Codable {
    let regular: String
}
