//
//  ProductCollectionViewCell.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 06/11/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    lazy var viewContent: UIView = createViewContent()
    lazy var viewVerticalStack = createVerticalStack()
    lazy var viewHorizontalStack = createHorizontalStack()
    lazy var imgViewProduct: UIImageView = createProductImageView()
    lazy var lblName = createNameLabel()
    lazy var lblPrice = createPriceLabel()
    lazy var txtViewDescription = createDescriptionView()
    lazy var ratingView: RatingStarView = createRatingView()
    lazy var lblRating = createRatingLabel()
    lazy var lblReviewCount = createReviewCountLabel()
    
    var product: ProductsEntity? {
        didSet {
            guard let product = product else { return }
            
            imgViewProduct.image = product.imageurl?.getImage
            lblName.text = product.name
            lblPrice.text = product.price.toRupees
            txtViewDescription.attributedText = product.productdescription?.withBoldText()
            lblRating.text = product.rating.toString
            ratingView.rating = product.rating.toInt
            lblReviewCount.text = "(\(product.reviewcount))"
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCellUIElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgViewProduct.image = nil
        lblName.text = nil
        lblPrice.text = nil
        txtViewDescription.attributedText = nil
    }
    
    private func createCellUIElement() {
        
        contentView.addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: contentView)
        
        viewContent.addSubview(imgViewProduct)
        let imgViewProductBottomLayout = imgViewProduct.bottomAnchor.constraint(greaterThanOrEqualTo: viewContent.bottomAnchor, constant: -12)
        imgViewProductBottomLayout.priority = .defaultLow
        viewContent.addConstraints([
            imgViewProduct.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 10),
            imgViewProduct.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 12),
            imgViewProduct.widthAnchor.constraint(equalToConstant: 90),
            imgViewProduct.heightAnchor.constraint(equalTo: imgViewProduct.widthAnchor, multiplier: 1.0/1.0),
            imgViewProductBottomLayout
        ])
        
        viewContent.addSubview(viewVerticalStack)
        viewContent.addConstraints([
            viewVerticalStack.topAnchor.constraint(equalTo: imgViewProduct.topAnchor),
            viewVerticalStack.leadingAnchor.constraint(equalTo: imgViewProduct.trailingAnchor, constant: 10),
            viewContent.trailingAnchor.constraint(equalTo: viewVerticalStack.trailingAnchor, constant: 10),
            viewContent.bottomAnchor.constraint(equalTo: viewVerticalStack.bottomAnchor, constant: 10),
        ])
        
        viewVerticalStack.addArrangedSubview(lblName)
        
        viewHorizontalStack.addArrangedSubview(lblRating)
        viewHorizontalStack.addArrangedSubview(ratingView)
        viewHorizontalStack.addArrangedSubview(lblReviewCount)
        
        viewVerticalStack.addArrangedSubview(viewHorizontalStack)
        viewVerticalStack.addArrangedSubview(lblPrice)
        
        viewVerticalStack.addArrangedSubview(txtViewDescription)
        
//        viewContent.addSubview(imgViewProduct)
//        let imgViewProductBottomLayout = imgViewProduct.bottomAnchor.constraint(greaterThanOrEqualTo: viewContent.bottomAnchor, constant: -12)
//        imgViewProductBottomLayout.priority = .defaultLow
//        viewContent.addConstraints([
//            imgViewProduct.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 10),
//            imgViewProduct.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 12),
//            imgViewProduct.widthAnchor.constraint(equalToConstant: 90),
//            imgViewProduct.heightAnchor.constraint(equalTo: imgViewProduct.widthAnchor, multiplier: 1.0/1.0),
//            imgViewProductBottomLayout
//        ])
//
//        viewContent.addSubview(lblName)
//        viewContent.addConstraints([
//            lblName.topAnchor.constraint(equalTo: imgViewProduct.topAnchor),
//            lblName.leadingAnchor.constraint(equalTo: imgViewProduct.trailingAnchor, constant: 10),
//            lblName.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -10),
//        ])
//
//        viewContent.addSubview(lblRating)
//        viewContent.addConstraints([
//            lblRating.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 5),
//            lblRating.leadingAnchor.constraint(equalTo: lblName.leadingAnchor)
//        ])
//
//        viewContent.addSubview(ratingView)
//        viewContent.addConstraints([
//            ratingView.topAnchor.constraint(equalTo: lblRating.topAnchor),
//            ratingView.leadingAnchor.constraint(equalTo: lblRating.trailingAnchor, constant: 6),
//            ratingView.bottomAnchor.constraint(equalTo: lblRating.bottomAnchor),
//            ratingView.heightAnchor.constraint(equalToConstant: 20),
//            ratingView.centerYAnchor.constraint(equalTo: lblRating.centerYAnchor, constant: 0)
//        ])
//
//        viewContent.addSubview(lblReviewCount)
//        viewContent.addConstraints([
//            lblReviewCount.topAnchor.constraint(equalTo: lblRating.topAnchor),
//            lblReviewCount.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 6),
//            lblReviewCount.bottomAnchor.constraint(equalTo: lblRating.bottomAnchor),
//            lblReviewCount.centerYAnchor.constraint(equalTo: lblRating.centerYAnchor, constant: 0)
//        ])
//
//        viewContent.addSubview(lblPrice)
//        viewContent.addConstraints([
//            lblPrice.topAnchor.constraint(equalTo: lblRating.bottomAnchor, constant: 5),
//            lblPrice.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
//            lblPrice.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
//        ])
//
//        viewContent.addSubview(txtViewDescription)
//        viewContent.addConstraints([
//            txtViewDescription.topAnchor.constraint(equalTo: lblPrice.bottomAnchor, constant: 5),
//            txtViewDescription.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
//            txtViewDescription.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
//            viewContent.bottomAnchor.constraint(greaterThanOrEqualTo: txtViewDescription.bottomAnchor, constant: 10)
//        ])
        
    }
}

class ProductColletioViewCellWaterFallLayout: UICollectionViewCell {
    static let identifier = "ProductColletioViewCellWaterFallLayout"
    
    lazy var viewContent: UIView = createViewContent()
    lazy var viewVerticalStack = createVerticalStack()
    lazy var viewHorizontalStack = createHorizontalStack()
    lazy var imgViewProduct: UIImageView = createProductImageView()
    lazy var selectedBtnFavourite: UIButton = createFavouriteButton()
    lazy var lblName = createNameLabel()
    lazy var lblPrice = createPriceLabel()
    lazy var txtViewDescription = createDescriptionView()
    lazy var ratingView: RatingStarView = createRatingView()
    lazy var lblRating = createRatingLabel()
    lazy var lblReviewCount = createReviewCountLabel()
    lazy var btnFavourite = createBtnFavourite()
    
    var productWaterFall: ProductsEntity? {
        didSet {
            guard let product = productWaterFall else { return }
            
            imgViewProduct.image = product.imageurl?.getImage
            lblName.text = product.name
            lblPrice.text = product.price.toRupees
            txtViewDescription.attributedText = product.productdescription?.withBoldText()
            lblRating.text = product.rating.toString
            ratingView.rating = product.rating.toInt
            lblReviewCount.text = "(\(product.reviewcount))"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCellForWaterFallLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgViewProduct.image = nil
        lblName.text = nil
        lblPrice.text = nil
        txtViewDescription.attributedText = nil
    }
    
    private func createCellForWaterFallLayout() {
        contentView.addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: contentView)
        viewContent.layer.cornerRadius = 23
        viewContent.clipsToBounds = true
        viewContent.layer.borderColor = .cornerColorCGGray
        viewContent.layer.borderWidth = 2
        
        viewContent.addSubview(imgViewProduct)
        viewContent.addConstraints([
            viewContent.topAnchor.constraint(equalTo: imgViewProduct.topAnchor, constant: 0),
            imgViewProduct.widthAnchor.constraint(equalToConstant: 200),
            imgViewProduct.heightAnchor.constraint(equalTo: imgViewProduct.widthAnchor, multiplier: 1.0/1.0)
        ])
        
        viewContent.addSubview(viewVerticalStack)
        viewContent.addConstraints([
            viewVerticalStack.topAnchor.constraint(equalTo: imgViewProduct.bottomAnchor, constant: 4),
            viewContent.bottomAnchor.constraint(equalTo: viewVerticalStack.bottomAnchor, constant: 18),
            viewVerticalStack.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 10),
            viewContent.trailingAnchor.constraint(equalTo: viewVerticalStack.trailingAnchor, constant: 10),
        ])
        
        viewContent.addSubview(selectedBtnFavourite)
        viewContent.bringSubviewToFront(selectedBtnFavourite)
        viewContent.addConstraints([
            viewContent.topAnchor.constraint(equalTo: selectedBtnFavourite.topAnchor, constant: 0),
            viewContent.trailingAnchor.constraint(equalTo: selectedBtnFavourite.trailingAnchor, constant: 0),
            selectedBtnFavourite.widthAnchor.constraint(equalToConstant: 75),
            selectedBtnFavourite.heightAnchor.constraint(equalTo: selectedBtnFavourite.widthAnchor, multiplier: 1.0/1.0)
        ])
        viewVerticalStack.addArrangedSubview(lblName)
        
        viewHorizontalStack.addArrangedSubview(lblRating)
        viewHorizontalStack.addArrangedSubview(ratingView)
        viewHorizontalStack.addArrangedSubview(lblReviewCount)
        
        viewVerticalStack.addArrangedSubview(viewHorizontalStack)
        viewVerticalStack.addArrangedSubview(lblPrice)
        
        viewVerticalStack.addArrangedSubview(txtViewDescription)
        
        viewVerticalStack.addArrangedSubview(btnFavourite)
        btnFavourite.layer.cornerRadius = 22
    }
}
