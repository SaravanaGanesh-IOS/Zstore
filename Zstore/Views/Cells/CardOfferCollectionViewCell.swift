//
//  CardOfferCollectionViewCell.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit

class CardOfferCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardOfferCollectionViewCell"
    lazy var viewContent: GradientView = createGradientView()
    lazy var stackViewContainer: UIStackView = createContainerStackView()
    lazy var lblCardName = createCardName()
    lazy var lblOfferDescription = createOfferDescription()
    lazy var lblMaxDiscount = createMaxDiscount()
    lazy var imgViewCardOffer = createImageCardOffer()
    
    
    var cardOffer: CardoffersEntity? {
        didSet {
            guard let cardOffer = cardOffer else { return }
            lblCardName.text = cardOffer.cardname
            imgViewCardOffer.image = cardOffer.imageURL?.getImage
            lblMaxDiscount.text = cardOffer.maxdiscount
            lblOfferDescription.text = cardOffer.offerDesc
            viewContent.vertical = true
            viewContent.applyGradient(with: gradientCGColorArray(for: cardOffer.offerid ?? CardOfferBank.hdfc.rawValue))
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
        
        lblCardName.text = nil
        imgViewCardOffer.image = nil
        lblMaxDiscount.text = nil
        lblOfferDescription.text = nil
        
    }
    
    
    private func createCellUIElement() {
        contentView.addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: contentView)
        
        //ImageView
        viewContent.addSubview(imgViewCardOffer)
        viewContent.addConstraints([
            imgViewCardOffer.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 13),
            imgViewCardOffer.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: 10),
            imgViewCardOffer.heightAnchor.constraint(equalToConstant: 90),
            imgViewCardOffer.widthAnchor.constraint(equalTo: imgViewCardOffer.heightAnchor, multiplier: 1.0/1.0),
            imgViewCardOffer.bottomAnchor.constraint(lessThanOrEqualTo: viewContent.bottomAnchor, constant: -13)
        ])
        
        viewContent.addSubview(stackViewContainer)
        let stackViewBottomLayout = stackViewContainer.bottomAnchor.constraint(greaterThanOrEqualTo: viewContent.bottomAnchor, constant: -12)
        stackViewBottomLayout.priority = .defaultLow
        viewContent.addConstraints([
            stackViewContainer.topAnchor.constraint(equalTo: imgViewCardOffer.topAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 10),
            stackViewContainer.trailingAnchor.constraint(equalTo: imgViewCardOffer.leadingAnchor, constant: -10),
            stackViewBottomLayout
        ])
        
        stackViewContainer.addArrangedSubview(lblCardName)
        stackViewContainer.addArrangedSubview(lblOfferDescription)
        stackViewContainer.addArrangedSubview(lblMaxDiscount)
    }
    
    func gradientCGColorArray(for offerBank: String) -> [CGColor] {
        guard let offerId = CardOfferBank(rawValue: offerBank) else { return [] }
        switch offerId {
        case .hdfc:
            return [.lightSkyBlueColor, .skyBlueColor]
        case .ifbc:
            return [.lightSunRiseColor, .darkSunRiseColor]
        case .axis:
            return [.lightWaterMelonColor, .darkWaterMelonColor]
        }
    }
}
