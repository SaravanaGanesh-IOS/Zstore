//
//  CardOfferCollectionViewCell+Ext.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit

extension CardOfferCollectionViewCell {
    internal func createCardName() -> CustomLabel {
        @UseAutolayout
        var label = CustomLabel(with: 16, textWeight: .medium, textColor: .white)
        return label
    }
    
    internal func createOfferDescription() -> CustomLabel {
        @UseAutolayout
        var label = CustomLabel(with: 15, textWeight: .regular, textColor: .white)
        label.lineCount = 2
        return label
    }
    
    internal func createMaxDiscount() -> CustomLabel {
        @UseAutolayout
        var label = CustomLabel(with: 20, textWeight: .semibold, textColor: .white)
        return label
    }
    
    internal func createImageCardOffer() -> UIImageView {
        @UseAutolayout
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 13
        return imgView
    }
    
    internal func createContainerStackView() -> UIStackView {
        @UseAutolayout
        var stackViewContainer = UIStackView()
        stackViewContainer.axis = .vertical
        stackViewContainer.spacing = 6
        stackViewContainer.distribution = .fill
        stackViewContainer.alignment = .leading
        return stackViewContainer
    }
    
    internal func createGradientView() -> GradientView  {
        @UseAutolayout
        var gradientView = GradientView()
        return gradientView
    }
}

