//
//  ImageCell.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    func configure(image: UIImage) {
        cellImageView.image = image
    }
}
