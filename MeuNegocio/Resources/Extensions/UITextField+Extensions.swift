//
//  UITextField+Extensions.swift
//  BarberVip
//
//  Created by Renilson Moreira on 13/08/22.
//

import Foundation
import UIKit

extension UITextField {
    
    func setPaddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
