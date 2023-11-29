//
//  SortOptionTableViewCell+Views.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 10/11/23.
//

import UIKit


extension SortOptionTableViewCell {
    internal func createStackViewContainer() -> UIStackView {
        @UseAutolayout
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }
    
    internal func createSortLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .body, color: .black)
        return label
    }
    
    internal func createCheckBoxButton() -> UIButton {
        @UseAutolayout
        var button = UIButton()
        button.setImage(.unChecked, for: .normal)
        return button
    }
    
    internal func createSortIcon() -> UIImageView {
        @UseAutolayout
        var imageView = UIImageView()
        imageView.image = .dollar
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
