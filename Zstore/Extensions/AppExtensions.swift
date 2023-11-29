//
//  AppExtensions.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import Foundation
import UIKit
import CoreData

//MARK: DECODABLE
extension Decodable {
    static func decodedData<T: Decodable>(_ data: Data) -> T? {
        
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(T.self, from: data)
    }
}

//MARK: - UINAVIGATION CONTROLLER
//extension UINavigationController  {
//    var appNavigationController: UINavigationController {
//        self.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .automatic
//        
//        self.navigationBar.barTintColor = .appBackgroundColor
//        self.navigationBar.backgroundColor = .appBackgroundColor
//        return self
//    }
//}

//MARK: STRING
extension String {
    var imageData: Data? {
        guard let url = URL(string: self),
              let data = try? Data(contentsOf: url)
        else { return nil}
        
        return data
    }
    
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.specialCharacters).joined(separator: "")
    }
    
    func withBoldText(font: UIFont? = nil) -> NSAttributedString {
        //Creating string without special character for this -> "*", "[", "]", "(", ")"
        let stringWithoutSpecialCharacter = self.withoutSpecialCharacters
        
        //Markdown Praser -> return Tuple contains bold string and the url for tappable link
        let getMarkdownValue = Constants.getMarkdonStrings(for: self)
        
        //Initializing the mutableattributestring with string without special character
        let removingURLFullString = stringWithoutSpecialCharacter.replacingOccurrences(of: getMarkdownValue.urlString, with: "")
        let fullString = NSMutableAttributedString(string: removingURLFullString)
        
        //Adding Bold Attribute
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 13)
        ]
        
        let fontColorAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor.systemGray
        ]
        
        let range = (removingURLFullString as NSString).range(of: getMarkdownValue.boldStr)
        
        //Adding URL Attribute
        let urlStringRange = (removingURLFullString as NSString).range(of: getMarkdownValue.tapableUrl)
        let fullStringRange = (removingURLFullString as NSString).range(of: removingURLFullString)
        
        //URL underline Attribute
        let urlAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.systemBlue
        ]
        fullString.addAttribute(.link, value: getMarkdownValue.urlString, range: urlStringRange)
        fullString.addAttributes(urlAttributes, range: urlStringRange)
        fullString.addAttributes(fontColorAttributes, range: fullStringRange)
        fullString.addAttributes(attributes, range: range)
        
        //return Attributed String
        return fullString
    }
}

//MARK: - CHARACTER SET
extension CharacterSet {
    static let specialCharacters = CharacterSet(charactersIn: "*()[]")
}


//MARK: NSMANAGEDOBJECT CONTEXT
extension NSManagedObjectContext {
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }
}

//MARK: - DATA
extension Data {
    
    var getImage: UIImage? {
        return UIImage(data: self) ?? nil
    }
}

//MARK: - DOUBLE
extension Double {
    var toString: String {
        return "\(self)"
    }
    
    var toInt: Int {
        return Int(self)
    }
    
    var toRupees: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return "\u{20B9}\(numberFormatter.string(from: NSNumber(floatLiteral: self)) ?? "0")"
    }
}

//MARK: - UIVIEW
extension UIView {
    func createViewContent() -> UIView {
        @UseAutolayout
        var contentView = UIView()
        return contentView
    }
}

//MARK: - UIIMAGE
extension UIImage {
    static let starFilled = UIImage(named: "StarFilled")
    static let starUnfilled = UIImage(named: "StarUnfilled")
    static let checked = UIImage(named: "Checked")
    static let unChecked = UIImage(named: "Unchecked")
    static let starOutline = UIImage(named: "StarOutline")
    static let dollar = UIImage(named: "Dollar")
    static let sortIcon = UIImage(named: "SortIcon")
    static let offerIcon = UIImage(named: "OfferIcon")
    static let closeIcon = UIImage(named: "Close")
    static let heartOutlineIcon = UIImage(named: "HeartOutline")
    static let heartFilledIcon = UIImage(named: "HeartFilled")
    static let searchIcon = UIImage(named: "SearchIcon")
}

//MARK: - NSSET
extension Set {
    func toArray<T>() -> [T] {
        let array = self.compactMap({ $0 as? T})
        return array
    }
}

extension Notification.Name {
    static let categoryInsertCompleted = Notification.Name("categoryInsertCompleted")
    static let cardOfferInsertCompleted = Notification.Name("cardOfferInsertCompleted")
    static let productInsertCompleted = Notification.Name("productInsertCompleted")
}


