//
//  CategoryCollectionViewCell.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 11/11/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    lazy var viewContent = createViewContent()
    lazy var btnCategory = createBtnCategory()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCellUIElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        btnCategory.setTitle(nil, for: .normal)
    }
    
    func createCellUIElement() {
        
        contentView.addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: contentView)
        
        viewContent.addSubview(btnCategory)
        viewContent.addConstraints([
            btnCategory.topAnchor.constraint(equalTo: viewContent.topAnchor),
            btnCategory.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: btnCategory.trailingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: btnCategory.bottomAnchor)
        ])
        btnCategory.layer.cornerRadius = 16
    }
}
