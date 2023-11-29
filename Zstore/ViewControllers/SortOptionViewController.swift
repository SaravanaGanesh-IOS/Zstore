//
//  ViewController.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import UIKit
protocol SortOptionViewControllerDelegate {
    func returnSortOption()
}

class SortOptionViewController: UIViewController {
    lazy var tableView: UITableView = createTableView()
    lazy var tableViewHeaderLabel: UILabel = createTableViewHeaderLabel()
    var delegate: SortOptionViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createUI()
    }
    
    internal func createUI() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 55
        tableView.constraintsForAnchoringTo(boundsOf: view)
        let heightConstraint = tableView.heightAnchor.constraint(equalToConstant: 145)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        self.preferredContentSize = CGSize(width: view.frame.width, height: 145)
        tableView.sectionHeaderTopPadding = 0
    }
}

extension SortOptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sorting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sortTableViewCell = tableView.dequeueReusableCell(withIdentifier: SortOptionTableViewCell.identifier, for: indexPath) as? SortOptionTableViewCell else { return UITableViewCell() }
        let sortName = Sorting.allCases[indexPath.row].rawValue
        sortTableViewCell.lblSortName.text = sortName.capitalized
        sortTableViewCell.imgSortIcon.image = UIImage(named: sortName.capitalized)
        
        sortTableViewCell.btnCheckbox.isSelected = sortName == Constants.getSortOption
        sortTableViewCell.btnCheckbox.tag = indexPath.row
        sortTableViewCell.btnCheckbox.setImage(sortName == Constants.getSortOption ? .checked : .unChecked, for: .normal)
        sortTableViewCell.btnCheckbox.addTarget(self, action: #selector(btnCheckbox_Tapped(_:)), for: .touchUpInside)
        return sortTableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.sectionHeaderHeight)
        headerView.addSubview(tableViewHeaderLabel)
        tableViewHeaderLabel.constraintsForAnchoringTo(boundsOf: headerView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}


