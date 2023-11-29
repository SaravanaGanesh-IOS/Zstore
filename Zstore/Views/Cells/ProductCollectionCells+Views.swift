//
//  ProductCollectionCells+Views.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 06/11/23.
//

import UIKit

extension ProductCollectionViewCell {
    internal func createNameLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .headline)
        label.lineCount = 3
        return label
    }
    
    internal func createPriceLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .headline)
        label.lineCount = 1
        return label
    }
    
    internal func createDescriptionView() -> UITextView {
        @UseAutolayout
        var textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        return textView
    }
    
    internal func createRatingLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: 13, textWeight: .semibold, textColor: .tangelo)
        return label
    }
    
    internal func createReviewCountLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .footnote, color: .systemGray2)
        return label
    }
    
    internal func createProductImageView() -> UIImageView {
        @UseAutolayout
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 10
        imgView.layer.borderColor = .cornerColorCGGray
        imgView.layer.borderWidth = 2
        return imgView
    }
    
    internal func createRatingView() -> RatingStarView {
        @UseAutolayout
        var ratingView = RatingStarView()
        return ratingView
    }
    
    internal func createVerticalStack() -> UIStackView {
        @UseAutolayout
        var verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill
        verticalStack.spacing = 10
        return verticalStack
    }
    
    internal func createHorizontalStack() -> UIStackView {
        @UseAutolayout
        var horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 5
        return horizontalStack
    }
}

extension ProductColletioViewCellWaterFallLayout {
    internal func createNameLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .headline)
        label.lineCount = 3
        return label
    }
    
    internal func createPriceLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .headline)
        label.lineCount = 1
        return label
    }
    
    internal func createDescriptionView() -> UITextView {
        @UseAutolayout
        var textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        return textView
    }
    
    internal func createRatingLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: 13, textWeight: .semibold, textColor: .tangelo)
        return label
    }
    
    internal func createReviewCountLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .footnote, color: .systemGray2)
        return label
    }
    
    internal func createProductImageView() -> UIImageView {
        @UseAutolayout
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }
    
    internal func createFavouriteButton() -> UIButton {
        @UseAutolayout
        var button = UIButton()
        button.setImage(.heartFilledIcon, for: .normal)
        return button
    }
    
    internal func createRatingView() -> RatingStarView {
        @UseAutolayout
        var ratingView = RatingStarView()
        return ratingView
    }
    
    internal func createVerticalStack() -> UIStackView {
        @UseAutolayout
        var verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill
        verticalStack.spacing = 10
        return verticalStack
    }
    
    internal func createHorizontalStack() -> UIStackView {
        @UseAutolayout
        var horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 5
        return horizontalStack
    }
    
    internal func createBtnFavourite() -> UIButton {
        @UseAutolayout
        var button = UIButton()
        button.setTitle("Add to Fav", for: .normal)
        button.setTitleColor(.secondaryGrayColor, for: .normal)
        button.setImage(.heartOutlineIcon, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.layer.borderColor = .separtorGrayColor
        button.layer.borderWidth = 1
        button.contentEdgeInsets = .init(top: 10, left: 8, bottom: 10, right: 8)
        return button
    }
}

