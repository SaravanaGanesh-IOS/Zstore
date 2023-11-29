//
//  SortOptionTableViewCell.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 10/11/23.
//

import UIKit

class SortOptionTableViewCell: UITableViewCell {
    static let identifier = "SortOptionTableViewCell"
    
    lazy var viewContent = createViewContent()
    lazy var stackViewContainer = createStackViewContainer()
    lazy var lblSortName = createSortLabel()
    lazy var btnCheckbox = createCheckBoxButton()
    lazy var imgSortIcon = createSortIcon()
    
    
    func getImageForSelected(isSelected: Bool) -> UIImage? {
        return isSelected ? .checked : .unChecked
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCellUIElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblSortName.text = nil
        btnCheckbox.setImage(nil, for: .normal)
        imgSortIcon.image = nil
    }
    
    func createCellUIElement() {
        contentView.addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: contentView)
        
        viewContent.addSubview(stackViewContainer)
        viewContent.addConstraints([
            stackViewContainer.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 5),
            viewContent.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: 5),
            stackViewContainer.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            viewContent.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor, constant: 16),
            stackViewContainer.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        stackViewContainer.addArrangedSubview(imgSortIcon)
        stackViewContainer.addArrangedSubview(lblSortName)
        stackViewContainer.addArrangedSubview(btnCheckbox)
        imgSortIcon.addConstraints([
            imgSortIcon.widthAnchor.constraint(equalTo: imgSortIcon.heightAnchor, multiplier: 1.0/1.0)
        ])
        
        btnCheckbox.addConstraints([
            btnCheckbox.widthAnchor.constraint(equalTo: btnCheckbox.heightAnchor, multiplier: 1.0/1.0)
        ])
        
        self.separatorInset = .zero
        self.selectionStyle = .none
    }

}
