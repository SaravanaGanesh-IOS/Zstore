//
//  HeaderCollectionViewCell+Views.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit

extension HeaderFooterCollectionViewCell {
    internal func createStackViewContainer() -> UIStackView {
        @UseAutolayout
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }
    
    internal func makeHeaderLabel() -> CustomLabel {
        @UseAutolayout
        var label = CustomLabel(with: .headline, color: .tangelo)
        return label
    }
    
    internal func makeHeaderImageView() -> UIImageView {
        @UseAutolayout
        var headerImageView = UIImageView()
        headerImageView.image = .offerIcon
        return headerImageView
    }
    
    internal func makeButtonClose() -> UIButton {
        @UseAutolayout
        var button = UIButton()
        button.setTitle("Applied: ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.secondaryGrayColor, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(.closeIcon, for: .normal)
        button.layer.borderColor = .borderBlueCGColor
        button.layer.borderWidth = 1
        button.contentEdgeInsets = .init(top: 7, left: 10, bottom: 7, right: 10)
        return button
    }
}
