//
//  ImagesListCell.swift
//  PixelStream
//
//  Created by Liz-Mary on 23.11.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let identifier = "ImagesListCell"
    
    @IBOutlet private var imageContent: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var imageViewGradient: UIImageView!
    
    func configure(with image: UIImage?, date: String, isLiked: Bool) {
        imageContent.image = image
        dateLabel.text = date
        imageViewGradient.image = UIImage(named: "rectangle")
        let likeImage = isLiked ? UIImage(named: "Like") : UIImage(named: "LikeEmpty")
        likeButton.setImage(likeImage, for: .normal)
    }
}
