//
//  RatingStarView.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit


class RatingStarView: UIStackView {
    var imgView: [UIImageView] = []
    var totalRating = 5
    var rating: Int = 0 {
        didSet {
            updateRating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImagesTotheStack()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateRating() {
        for imageView in imgView {
            if rating <= imageView.tag {
                imageView.image = .starUnfilled
            } else {
                imageView.image = .starFilled
            }
        }
        self.imgView.forEach { self.addArrangedSubview($0) }
    }
    
    func addImagesTotheStack() {
        (0..<totalRating).forEach { index in
            let imageView = UIImageView()
            imageView.tag = index
            imageView.image = .starUnfilled
            self.imgView.append(imageView)
        }
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .leading
    }
}
