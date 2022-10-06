//
//  UIColor+Extensions.swift
//  BarberVip
//
//  Created by Leonardo Portes on 11/02/22.
//

import UIKit

public extension UIColor {
    
    struct BarberColors {
        
        // MARK: - Home colors
        public static var lightBrown: UIColor {
            return UIColor(named: "lightBrown") ?? UIColor.yellow
        }
        
        public static var darkGray: UIColor {
            return UIColor(named: "darkGray") ?? UIColor.darkGray
        }

        public static var grayDarkest: UIColor {
            return UIColor(named: "grayDarkest") ?? UIColor.darkGray
        }
        
        public static var grayDescription: UIColor {
            return UIColor(named: "grayDescription") ?? UIColor.darkGray
        }
        
        public static var greenMedium: UIColor {
            return UIColor(named: "greenMedium") ?? UIColor.darkGray
        }
        
        public static var lightGray: UIColor {
            return UIColor(named: "lightGray") ?? UIColor.lightGray
        }

        public static var yellowDark: UIColor {
            return UIColor(named: "yellowDark") ?? UIColor.systemYellow
        }

        public static var yellowHighDark: UIColor {
            return UIColor(named: "yellowHighDark") ?? UIColor.systemYellow
        }

    }
    
}
