//
//  HeaderCollectionViewCell.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit

class HeaderFooterCollectionViewCell: UICollectionReusableView {
    static let identifier = "HeaderFooterCollectionViewCell"
    lazy var viewContent = createViewContent()
    lazy var stackViewContainer = createStackViewContainer()
    lazy var lblHeader = makeHeaderLabel()
    lazy var imgViewHeader = makeHeaderImageView()
    lazy var btnClose = makeButtonClose()
    var cellKind: String? {
        didSet {
            switch cellKind {
            case UICollectionView.elementKindSectionHeader: createHeaderUIComponent()
                break
            case UICollectionView.elementKindSectionFooter: createFooterUIComponent()
                break
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
           
    }
    
    private func createHeaderUIComponent() {
        addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: self)
        
        viewContent.addSubview(stackViewContainer)
        stackViewContainer.constraintsForAnchoringTo(boundsOf: viewContent)
        stackViewContainer.addArrangedSubview(imgViewHeader)
        imgViewHeader.addConstraints([
            imgViewHeader.heightAnchor.constraint(equalTo: imgViewHeader.widthAnchor, multiplier: 1.0/1.0)
        ])
        stackViewContainer.addArrangedSubview(lblHeader)
    }
    
    private func createFooterUIComponent() {
        addSubview(viewContent)
        viewContent.constraintsForAnchoringTo(boundsOf: self)
        
        viewContent.addSubview(btnClose)
        let btnCloseBottomConstraint = btnClose.bottomAnchor.constraint(greaterThanOrEqualTo: viewContent.bottomAnchor, constant: 12)
        btnCloseBottomConstraint.priority = .defaultLow
        viewContent.addConstraints([
            btnClose.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 5),
            btnClose.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 5),
            btnClose.heightAnchor.constraint(equalToConstant: 44),
            btnCloseBottomConstraint
        ])
        btnClose.layer.cornerRadius = 22
    }
}
