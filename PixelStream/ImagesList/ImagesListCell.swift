//
//  ImagesListCell.swift
//  PixelStream
//
//  Created by Liz-Mary on 23.11.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let identifier = "ImagesListCell"
    
    @IBOutlet var imageContent: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
}
