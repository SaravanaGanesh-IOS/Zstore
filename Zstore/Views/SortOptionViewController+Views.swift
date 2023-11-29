//
//  SortOptionViewController.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 10/11/23.
//

import UIKit

extension SortOptionViewController {
    internal func createTableView() -> UITableView {
        @UseAutolayout
        var tableView = UITableView()
        tableView.register(SortOptionTableViewCell.self, forCellReuseIdentifier: SortOptionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 55
        tableView.isScrollEnabled = false
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.layoutMargins = .zero
        return tableView
    }
    
    internal func createTableViewHeaderLabel() -> UILabel {
        @UseAutolayout
        var label = CustomLabel(with: .footnote, color: .gray)
        label.text = "Filter Order: From Top to Bottom"
        label.textAlignment = .center
        return label
    }
}

//MARK: - BUTTON ACTIONS
extension SortOptionViewController {
    @objc
    internal func btnCheckbox_Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        Constants.set(Sorting.allCases[sender.tag].rawValue)
        sender.setImage(sender.isSelected ? .checked : .unChecked, for: .normal)
        tableView.reloadData()
        delegate?.returnSortOption()
        self.dismiss(animated: true)
    }
}
