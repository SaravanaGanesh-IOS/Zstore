//
//  StoresHomeViewController+Views.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 06/11/23.
//

import UIKit
import CoreData

//MARK: STORESHOMEVIEWCONTROLLER VIEWS
extension StoresHomeViewController {
    internal func makeCollectionView() -> UICollectionView {
        let viewLayout = createLayout()
        @UseAutolayout
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.register(HeaderFooterCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderFooterCollectionViewCell.identifier)
        collectionView.register(HeaderFooterCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HeaderFooterCollectionViewCell.identifier)
        collectionView.register(CardOfferCollectionViewCell.self, forCellWithReuseIdentifier: CardOfferCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(ProductColletioViewCellWaterFallLayout.self, forCellWithReuseIdentifier: ProductColletioViewCellWaterFallLayout.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration.init(appearance: .insetGrouped)
            config.headerMode = .firstItemInSection
            guard let self = self else { return nil }
            let storeSection = StoreSection(rawValue: section)
            switch storeSection {
            case .catagories:
                return self.createCategoryLayoutSection()
            case .cardoffer:
                return self.createCardOfferLayoutSection()
            case .product:
                if let layoutType = arrCategory.first(where: { $0.categoryid == Constants.getCategory })?.layout {
                    if layoutType == Layout.waterfall.rawValue {
                        return self.createProductWaterFallLayoutSection()
                    } else {
                        return self.createProductLayoutSection()
                    }
                }
            case .none:
                break
            }
            return nil
        }
    }
    
    internal func createSortButton() -> UIButton {
        @UseAutolayout
        var button = UIButton()
        button.setTitleColor(.tangelo, for: .normal)
        button.setImage(.sortIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(btnSort_Tapped(_:)), for: .touchUpInside)
        return button
    }
    
    internal func createContainerView() -> UIView {
        @UseAutolayout
        var containerView = UIView()
        return containerView
    }
    
    internal func createSearchButton() -> UIBarButtonItem {
        var rightBarButton = UIBarButtonItem(image: .searchIcon, style: .plain, target: self, action: #selector(btnSearch_Tapped(_:)))
        rightBarButton.tintColor = .black
        return rightBarButton
    }
    
    internal func createSearchBar() -> UISearchBar {
        @UseAutolayout
        var searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .default
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
    }
    
    internal func createMaskView() -> UIView {
        @UseAutolayout
        var containerView = UIView()
        containerView.backgroundColor = .black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        containerView.tag = 1
        containerView.addGestureRecognizer(tap)
        return containerView
    }
    
    internal func createActivityIndicator() -> UIActivityIndicatorView {
        @UseAutolayout
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }
    
    internal func headerFooterView(_ collectionView: UICollectionView, and kind: String, for indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFooterCollectionViewCell.identifier, for: indexPath) as? HeaderFooterCollectionViewCell else { return UICollectionReusableView() }
            header.cellKind = kind
            header.lblHeader.text = "Offer"
            
            return header
        case UICollectionView.elementKindSectionFooter:
            if CardoffersEntity.getSelectedOffer() == nil { return UICollectionReusableView() }
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFooterCollectionViewCell.identifier, for: indexPath) as? HeaderFooterCollectionViewCell,
                  let cardOffer = CardoffersEntity.getSelectedOffer()
            else { return UICollectionReusableView() }
            
            footer.cellKind = kind
            footer.btnClose.setTitle("Applied: \(cardOffer.cardname ?? "")", for: .normal)
            footer.btnClose.accessibilityIdentifier = cardOffer.offerid
            footer.btnClose.addTarget(self, action: #selector(removeOffer_Tapped(_:)), for: .touchUpInside)
            
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension StoresHomeViewController: UISearchBarDelegate {
    
    @objc
    internal func closeView(_ sender: AnyObject) {
        guard let maskView = navigationController?.view.viewWithTag(1) else { return }
        maskView.removeFromSuperview()
    }
    
    @objc
    internal func btnCategory_Tapped(_ sender: UIButton) {
        Constants.setCategory(arrCategory[sender.tag].categoryid ?? selectedCategoryId)
        sender.isSelected = !sender.isSelected
        selectedCatFetch()
    }
    
    @objc
    internal func btnSearch_Tapped(_ sender: AnyObject) {
        setupSearchBar()
    }
    
    @objc
    internal func removeOffer_Tapped(_ sender: UIButton) {
        CardoffersEntity.resetOfferSelection()
        selectedCatFetch()
    }
    
    @objc
    internal func addToFavourite_Tapped(_ sender: UIButton) {
        ProductsEntity.addToFavourite(for: sender.accessibilityIdentifier ?? "", isAdd: true)
        reloadSection(with: 2)
    }
    
    @objc
    internal func removeFavourite_Tapped(_ sender: UIButton) {
        ProductsEntity.addToFavourite(for: sender.accessibilityIdentifier ?? "", isAdd: false)
        reloadSection(with: 2)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        setupSearch()
        performBatchfetchForProduct()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        selectedCatFetch(searchText)
    }
}
