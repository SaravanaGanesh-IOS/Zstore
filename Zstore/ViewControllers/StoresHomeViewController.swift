//
//  StoresHomeViewController.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import UIKit
import CoreData

class StoresHomeViewController: UIViewController {
    weak var mainCoordinator: MainCoordinator?
    fileprivate lazy var collectionView: UICollectionView = makeCollectionView()
    fileprivate lazy var sortButton: UIButton = createSortButton()
    fileprivate lazy var searchButton: UIBarButtonItem = createSearchButton()
    fileprivate lazy var searchBar: UISearchBar = createSearchBar()
    lazy var activityIndicator: UIActivityIndicatorView = createActivityIndicator()
    
    lazy var arrCardOffer = {
        return CardoffersEntity.getCardOffers()
    }()
    internal lazy var arrCategory = {
        return CategoryEntity.getCategories()
    }()
    private var storesViewModel: StoresViewModel? {
        didSet {
            fetchStores()
        }
    }
    var selectedCategoryId = "" {
        didSet {
            selectedCatFetch()
        }
    }
    
    internal var fetchResultController: NSFetchedResultsController<ProductsEntity>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDataModel()
        createUIComponent()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initializeDataModel() {
        
        storesViewModel = StoresViewModel(delegate: self)
        NotificationCenter.default.addObserver(self, selector: #selector(insertCompleted(notfication:)), name: .categoryInsertCompleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(insertCompleted(notfication:)), name: .cardOfferInsertCompleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(insertCompleted(notfication:)), name: .productInsertCompleted, object: nil)
        fetchResultController?.delegate = self
        performfetch()
    }
    
    private func createUIComponent() {
        
        title = "Zstore"
        view.addSubview(collectionView)
        collectionView.constraintsForAnchoringTo(boundsOf: view)
        
        //Adding Sort button Autolayout
        view.addSubview(sortButton)
        let btnSortConstraints = [sortButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.addButtonWidth),
                                 sortButton.widthAnchor.constraint(equalToConstant: Constants.addButtonWidth),
                                 sortButton.heightAnchor.constraint(equalTo: sortButton.widthAnchor, multiplier: 1.0/1.0),
                                 view.trailingAnchor.constraint(equalTo: sortButton.trailingAnchor, constant: 5)]
        view.addConstraints(btnSortConstraints)
        sortButton.layer.cornerRadius = 0.5 * Constants.addButtonWidth
        view.bringSubviewToFront(sortButton)
        setupSearch()
    }
    
    func setupSearchBar() {
        searchBar.becomeFirstResponder()
        let searchTextField = searchBar.searchTextField
        searchTextField.layer.cornerRadius = 18
        searchTextField.layer.masksToBounds = false
        searchTextField.backgroundColor = .appBackgroundColor
        searchBar.tintColor = .tangelo
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = .skyBlueColor
        UISearchBar.appearance().setImage(.searchIcon, for: .search, state: .normal)
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func setupSearch() {
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    func loadActivityIndicator() {
        let maskView = createMaskView()
        navigationController?.view.addSubview(maskView)
        maskView.constraintsForAnchoringTo(boundsOf: navigationController?.view ?? view)
        maskView.addSubview(activityIndicator)
        activityIndicator.constraintsForAnchoringTo(boundsOf: maskView)
        maskView.tag = 100
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func fetchStores() {
        
        if arrCategory.isEmpty {
            loadActivityIndicator()
        }
        storesViewModel?.fetchStores()
        
        Constants.getSortOption.isEmpty ? Constants.set(Sorting.Rating.rawValue) : selectedCatFetch()
    }

}

//MARK: FETCH RESULT VIEW CONTROLLER
extension StoresHomeViewController: StoresViewModelDelegate  {
    func performfetch() {
        do {
            try fetchResultController?.performFetch()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func performBatchfetchForProduct() {
        do {
            try fetchResultController?.performFetch()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.performBatchUpdates {
                    self.collectionView.reloadSections(IndexSet(integer: StoreSection.catagories.rawValue))
                    self.collectionView.reloadSections(IndexSet(integer: StoreSection.product.rawValue))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension StoresHomeViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        performfetch()
    }
}

//MARK: UICOLLECTIONVIEW DELEGATES
extension StoresHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StoreSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let storeSection = StoreSection(rawValue: section)
        switch storeSection {
        case .catagories:
            return arrCategory.count 
        case .cardoffer:
            return arrCardOffer.count
        case .product:
            return fetchResultController?.fetchedObjects?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = StoreSection(rawValue: indexPath.section)
        switch section {
        case .catagories:
            guard let categoryCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            
            categoryCell.btnCategory.addTarget(self, action: #selector(btnCategory_Tapped(_:)), for: .touchUpInside)
            categoryCell.btnCategory.tag = indexPath.row
            categoryCell.btnCategory.clipsToBounds = true
            if Constants.getCategory == arrCategory[indexPath.row].categoryid {
                categoryCell.btnCategory.isSelected = true
                categoryCell.btnCategory.setTitleColor(.tangelo, for: .selected)
                categoryCell.btnCategory.layer.borderColor = UIColor.tangelo?.cgColor
                categoryCell.btnCategory.layer.borderWidth = 1.5
                categoryCell.backgroundColor = .tangeloLightColor
                if searchBar.text != "" {
                    categoryCell.btnCategory.setTitle("\(arrCategory[indexPath.row].name ?? "") \(fetchResultController?.fetchedObjects?.count ?? 0)", for: .normal)
                } else {
                    categoryCell.btnCategory.setTitle(arrCategory[indexPath.row].name, for: .normal)
                }
            } else {
                categoryCell.btnCategory.isSelected = false
                categoryCell.btnCategory.setTitleColor(.secondaryGrayColor, for: .normal)
                categoryCell.btnCategory.layer.borderColor = UIColor.secondaryGrayColor?.cgColor
                categoryCell.btnCategory.layer.borderWidth = 1.5
                categoryCell.backgroundColor = .white
                categoryCell.btnCategory.setTitle(arrCategory[indexPath.row].name, for: .normal)
            }
            
            return categoryCell
        case .cardoffer:
            guard let cardOfferCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CardOfferCollectionViewCell.identifier, for: indexPath) as? CardOfferCollectionViewCell else { return UICollectionViewCell() }
            
            cardOfferCell.cardOffer = arrCardOffer[indexPath.row]
            return cardOfferCell
        case .product:
            if let layoutType = arrCategory.first(where: { $0.categoryid == Constants.getCategory })?.layout {
                if layoutType != Layout.waterfall.rawValue {
                    guard let productCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
                    productCell.product = fetchResultController?.object(at: IndexPath(row: indexPath.row, section: 0))
                    return productCell
                } else {
                    guard let productWaterfallCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ProductColletioViewCellWaterFallLayout.identifier, for: indexPath) as? ProductColletioViewCellWaterFallLayout else { return UICollectionViewCell() }
                    
                    
                    let productObj = fetchResultController?.object(at: IndexPath(row: indexPath.row, section: 0))
                    productWaterfallCell.productWaterFall = productObj
                    
                    if productObj?.isFavourite == true {
                        productWaterfallCell.btnFavourite.isHidden = true
                        productWaterfallCell.selectedBtnFavourite.isHidden = false
                    } else {
                        productWaterfallCell.btnFavourite.isHidden = false
                        productWaterfallCell.selectedBtnFavourite.isHidden = true
                    }
                    productWaterfallCell.btnFavourite.addTarget(self, action: #selector(addToFavourite_Tapped(_:)), for: .touchUpInside)
                    productWaterfallCell.selectedBtnFavourite.addTarget(self, action: #selector(removeFavourite_Tapped(_:)), for: .touchUpInside)
                    productWaterfallCell.btnFavourite.accessibilityIdentifier = productObj?.productid
                    productWaterfallCell.selectedBtnFavourite.accessibilityIdentifier = productObj?.productid
                    return productWaterfallCell
                }
            }
            return UICollectionViewCell()
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = StoreSection(rawValue: indexPath.section)
        switch section {
        case .catagories:
            return UICollectionReusableView()
        case .cardoffer:
            return headerFooterView(collectionView, and: kind, for: indexPath)
        case .product:
            return UICollectionReusableView()
        case .none:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = StoreSection(rawValue: indexPath.section)
        switch section {
        case .catagories:
            return
        case .cardoffer:
            if CardoffersEntity.getSelectedOffer() != nil { return }
            CardoffersEntity.updateOfferSelection(for: arrCardOffer[indexPath.row].offerid ?? "")
            selectedCatFetch()
            break
        case .product:
            return
        case .none:
            return
        }
    }
    
    internal func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    internal func reloadSection(with section: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.performBatchUpdates {
                self.collectionView.reloadSections(IndexSet(integer: section))
            }
        }
    }
}

//MARK: - ACTIONS
extension StoresHomeViewController: UIPopoverPresentationControllerDelegate {
    @objc
    internal func btnSort_Tapped(_ sender: UIButton) {
        let sortView = SortOptionViewController()
        sortView.delegate = self
        sortView.modalPresentationStyle = .popover
        sortView.popoverPresentationController?.sourceView = sender
        self.popoverPresentationController?.sourceRect = CGRect(origin: sortView.view.frame.origin, size: .init(width: 100, height: 100))
        sortView.popoverPresentationController?.permittedArrowDirections = .down
        sortView.popoverPresentationController?.delegate = self
        self.present(sortView, animated: true)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension StoresHomeViewController: SortOptionViewControllerDelegate {
    func returnSortOption() {
        selectedCatFetch()
    }
    
    func selectedCatFetch(_ searchText: String? = "") {
        fetchResultController =  {
            let fetchRequest = ProductsEntity.fetchRequest()
            let categoryPredicate = NSPredicate(format: "catagoryid contains[cd] %@", Constants.getCategory)
            let searchString = searchText ?? ""
            if !searchString.isEmpty {
                let productSearchPredicate = NSPredicate(format: "name contains[cd] %@", searchText ?? "")
                let compoundORPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, productSearchPredicate])
                let compoundANDPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, productSearchPredicate])
                fetchRequest.predicate = Constants.getCategory.isEmpty ? compoundORPredicate : compoundANDPredicate
            } else {
                fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate])
            }
            let sortDescriptor = NSSortDescriptor(key: Constants.getSortOption, ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: .viewContext,
                                                                   sectionNameKeyPath: nil, cacheName: nil)
            return fetchResultController
        }()
        performBatchfetchForProduct()
    }
}


//MARK: - STORESHOMEVIEWCONTROLLER
extension StoresHomeViewController {
    @objc
    func insertCompleted(notfication: NSNotification) {
        switch notfication.name {
        case .cardOfferInsertCompleted:
            arrCardOffer = CardoffersEntity.getCardOffers()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .categoryInsertCompleted:
            arrCategory = CategoryEntity.getCategories()
            Constants.getCategory.isEmpty ? Constants.setCategory(arrCategory.first?.categoryid ?? "") : nil
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .productInsertCompleted:
            selectedCatFetch()
            DispatchQueue.main.async {
                let maskView = self.navigationController?.view.viewWithTag(100)
                maskView?.removeFromSuperview()
                self.activityIndicator.stopAnimating()
            }
        default:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
