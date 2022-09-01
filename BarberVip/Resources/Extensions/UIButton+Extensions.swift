//
//  UIButton+Extensions.swift
//  BarberVip
//
//  Created by Renilson Moreira on 30/08/22.
//
import UIKit

extension UIButton {
    func loadingIndicator(show: Bool) {
        if show {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.color = .white
            self.titleLabel?.layer.opacity = 0.0
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            for view in self.subviews {
                if let indicator = view as? UIActivityIndicatorView {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    self.titleLabel?.layer.opacity = 1
                }
            }
        }
    }
}
