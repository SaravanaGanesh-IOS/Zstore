//
//  Constants.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation

typealias MarkdownValue = (boldStr: String, urlString: String, tapableUrl: String)
let Defaults = UserDefaults.standard

struct Constants {
    static let baseURL = "https://raw.githubusercontent.com/princesolomon/zstore/main"
    static let path = "/data.json"
    static let get = "GET"
    static let noInternet = "No internet, please switch on your mobile data or connect to a wifi"
    static let addButtonWidth = 60.0
    static let fetchSortOptions = "fetchSortOption"
    static let selectedCategoryKey = "selectedCategoryKey"
    
    static func set(_ sortOption: String) {
        Defaults.set(sortOption, forKey: fetchSortOptions)
        Defaults.synchronize()
    }
    
    static var getSortOption: String {
        return Defaults.string(forKey: fetchSortOptions) ?? Sorting.Rating.rawValue
    }
    
    static func setCategory(_ selectedCategory: String) {
        Defaults.set(selectedCategory, forKey: selectedCategoryKey)
        Defaults.synchronize()
    }
    
    static var getCategory: String {
        return Defaults.string(forKey: selectedCategoryKey) ?? ""
    }
}

extension Constants {
    static func getMarkdonStrings(for str: String) -> MarkdownValue {
        guard str != "" else { return ("", "", "") }
        let boldValue = str.slice(from: "**", to: "**") ?? ""
        let urlString = str.slice(from: "](", to: ")") ?? ""
        let tapableUrl = str.slice(from: "[", to: "]") ?? ""
        return (boldStr: boldValue, urlString: urlString, tapableUrl: tapableUrl)
    }
}
