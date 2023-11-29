//
//  CategoryCollectionViewCell+Views.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//

import UIKit

extension CategoryCollectionViewCell {
    
    internal func createBtnCategory() -> UIButton {
        @UseAutolayout
        var button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderColor = .separtorGrayColor
        button.layer.borderWidth = 1.5
        button.contentEdgeInsets = .init(top: 7, left: 10, bottom: 7, right: 10)
        return button
    }
}
