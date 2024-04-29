//
//  DetailsViewController.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var fullSizeImageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullSizeImageView.image = image
    }
    
}
