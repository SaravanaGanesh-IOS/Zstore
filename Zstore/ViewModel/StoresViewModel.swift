//
//  StoresViewModel.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

protocol StoresViewModelDelegate {
    func performfetch()
}

final class StoresViewModel: NSObject {
    private (set) var delegate: StoresViewModelDelegate?
    
    init(delegate: StoresViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func fetchStores() {
        StoresAPI.shared.getStores { result in
            switch result {
            case .success(let stores):
                self.insertDatas(from: stores)
                break
            case .failure(let error):
                print(error == .noInternet ? Constants.noInternet : error.localizedDescription)
                break
            }
        }
    }
    
}

//MARK: INSERT DATA INTO DB
extension StoresViewModel {
    
    private func insertDatas(from stores: Stores) {
        CategoryEntity.insertCategory(from: stores)
    }
}
