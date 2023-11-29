//
//  Coordinator.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var childController: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    
    func startCoordinator()
}

class MainCoordinator: Coordinator {
    var childController: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func startCoordinator() {
        let initialViewController = StoresHomeViewController()
        initialViewController.mainCoordinator = self
        navigationController.pushViewController(initialViewController, animated: true)
    }
    
    func getSortOptionViewController() -> SortOptionViewController {
        let sortOptionVC = SortOptionViewController()
        return sortOptionVC
    }
}
