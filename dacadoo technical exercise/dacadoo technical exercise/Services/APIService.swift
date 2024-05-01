//
//  APIService.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 30.04.2024.
//

import UIKit

protocol APIService {
    func fetchImagesWithDescription(for query: String) async -> Result<[ImageWithDescription], Error>
}
