//
//  UIView+Extensions.swift
//  BarberVip
//
//  Created by Leonardo Portes on 11/02/22.
//

import UIKit

extension UIView {
    
    /// Adiciona bordas arredondadas em um componente UIView
    func roundCorners(cornerRadius: CGFloat, typeCorners: CACornerMask? = nil, all: Bool = false) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        if all {
            self.layer.maskedCorners = [.topLeft,
                                        .topRight,
                                        .bottomLeft,
                                        .bottomRight]
        } else {
            self.layer.maskedCorners = typeCorners ?? [.topLeft,
                                                       .topRight,
                                                       .bottomLeft,
                                                       .bottomRight]
        }
    }
    
    /// Adiciona sombra em uma UIView
    func addShadow(color: UIColor? = .black, size: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
}

extension CACornerMask {
    static public let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    static public let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}
