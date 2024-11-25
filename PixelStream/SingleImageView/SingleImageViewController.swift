//
//  SingleImageViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 25.11.2024.
//

import UIKit

class SingleImageViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
