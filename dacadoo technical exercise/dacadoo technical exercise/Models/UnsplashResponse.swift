//
//  UnsplashResponse.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import Foundation

struct UnsplashResponse: Decodable {
    let results: [UnsplashPhoto]
}
