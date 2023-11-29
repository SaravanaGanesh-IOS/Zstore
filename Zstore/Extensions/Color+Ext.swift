//
//  Color+Ext.swift
//  Zstore
//
//  Created by Saravana Ganesh L on 05/11/23.
//

import UIKit

extension UIColor {
    static let appBackgroundColor: UIColor = .white
    static let tangelo = UIColor(named: .tangeloColor)
    static let secondaryGrayColor = UIColor(named: .secondaryGrayColor)
    static let borderBlueColor = UIColor.init(named: .borderBlueColor)
    static let cornerColorGray = UIColor.init(named: .cornerColorGray)
    static let tangeloLightColor = UIColor.init(named: .tangeloLightColor)
}

extension CGColor {
    
    static let darkSunRiseColor: CGColor = (UIColor(named: .darkSunRiseColor) ?? .black).cgColor
    static let darkWaterMelonColor: CGColor = (UIColor(named: .darkWaterMelonColor) ?? .black).cgColor
    static let lightSkyBlueColor: CGColor = (UIColor(named: .lightSkyBlueColor) ?? .black).cgColor
    static let lightSunRiseColor: CGColor = (UIColor(named: .lightSunRiseColor) ?? .black).cgColor
    static let lightWaterMelonColor: CGColor = (UIColor(named: .lightWaterMelonColor) ?? .black).cgColor
    static let skyBlueColor: CGColor = (UIColor(named: .skyBlueColor) ?? .black).cgColor
    static let separtorGrayColor: CGColor = (UIColor(named: .separtorGrayColor) ?? .black).cgColor
    static let borderBlueCGColor = UIColor(named: .borderBlueColor)?.cgColor
    static let cornerColorCGGray = UIColor(named: .cornerColorGray)?.cgColor
    static let tangeloLightCGColor = UIColor.init(named: .tangeloLightColor)?.cgColor
    
}

extension String {
    
    static let tangeloColor = "Tangelo"
    static let darkSunRiseColor = "DarkSunRiseColor"
    static let darkWaterMelonColor = "DarkWaterMelonColor"
    static let lightSkyBlueColor = "LightSkyBlueColor"
    static let lightSunRiseColor = "LightSunRiseColor"
    static let lightWaterMelonColor = "LightWaterMelonColor"
    static let skyBlueColor = "SkyBlueColor"
    static let separtorGrayColor = "SepartorGrayColor"
    static let secondaryGrayColor = "SecondaryTextGrayColor"
    static let borderBlueColor = "BorderBlueColor"
    static let cornerColorGray = "CornerColorGray"
    static let tangeloLightColor = "TangeloLightColor"
}
