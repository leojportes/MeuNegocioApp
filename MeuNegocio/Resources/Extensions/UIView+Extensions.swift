//
//  UIView+Extensions.swift
//  MeuNegocio
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
    func addShadow(color: UIColor? = .black, size: CGSize = CGSize(width: 0.0, height: 1), opacity: Float = 0.3, radius: CGFloat = 2) {
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func addTopBorder(with color: UIColor? = .BarberColors.separatorGray, andWidth borderWidth: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addBottomBorder(with color: UIColor? = .BarberColors.separatorGray, andWidth borderWidth: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
}

extension CACornerMask {
    static public let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    static public let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}

extension UIView {
    func loadingIndicatorView(show: Bool = true) {
        if show {
            DispatchQueue.main.async {
                let indicator = UIActivityIndicatorView()
                self.addSubview(indicator)
                let buttonHeight = self.bounds.size.height
                let buttonWidth = self.bounds.size.width
                indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
                indicator.color = .darkGray
                self.layer.opacity = 0.5
                indicator.startAnimating()
            }
        } else {
            for view in self.subviews {
                if let indicator = view as? UIActivityIndicatorView {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    self.layer.opacity = 1
                }
            }
        }
    }
}
