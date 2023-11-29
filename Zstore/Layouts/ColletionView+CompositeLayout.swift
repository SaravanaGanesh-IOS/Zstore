//
//  ColletionView+CompositeLayout.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 09/11/23.
//

import UIKit

extension StoresHomeViewController {
    internal func createCardOfferLayoutSection() -> NSCollectionLayoutSection {
        //item
        let collectionViewItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)))
        
        collectionViewItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        
        //group
        let groupItem = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(100)), subitems: [collectionViewItem])
        
        //section
        let section = NSCollectionLayoutSection(group: groupItem)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        section.orthogonalScrollingBehavior = .paging
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        
        //header
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            
            layoutSize: headerSize,
            
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        
        //footer
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            
            layoutSize: footerSize,
            
            elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
//        if arrCategory.count != 0 {
            section.boundarySupplementaryItems = CardoffersEntity.getSelectedOffer() == nil ? [sectionHeader] : [sectionHeader, sectionFooter]
//        } else {
//            section.boundarySupplementaryItems = []
//        }
        
        return section
    }
    
    internal func createProductWaterFallLayoutSection() -> NSCollectionLayoutSection {
        //item
        let collectionViewItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)))
        
        collectionViewItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        collectionViewItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: NSCollectionLayoutSpacing.fixed(4), trailing: .none, bottom: NSCollectionLayoutSpacing.fixed(4))
        
        //group
        let firstGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(100)), subitems: [collectionViewItem])
        let secondGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(100)), subitems: [collectionViewItem])
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), subitems: [firstGroup, secondGroup])
        
        //section
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    internal func createProductLayoutSection() -> NSCollectionLayoutSection {
        //item
        let collectionViewItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)))

        collectionViewItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        collectionViewItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: NSCollectionLayoutSpacing.fixed(12), trailing: .none, bottom: NSCollectionLayoutSpacing.fixed(12))

        //group
        let groupItem = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), subitems: [collectionViewItem])

        //section
        let section = NSCollectionLayoutSection(group: groupItem)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        section.orthogonalScrollingBehavior = .none
        //        section.boundarySupplementaryItems = [header]

        return section
    }
    
    internal func createCategoryLayoutSection() -> NSCollectionLayoutSection {
        //item
        let collectionViewItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .absolute(32)))
        
        collectionViewItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        collectionViewItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(4), top: .none, trailing: .fixed(4), bottom: .none)
        
        //group
        let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), subitems: [collectionViewItem])
        
        //section
        let section = NSCollectionLayoutSection(group: groupItem)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
}
