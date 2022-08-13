//
//  UITextFieldBarber.swift
//  BarberVip
//
//  Created by Renilson Moreira on 13/08/22.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    init(titlePlaceholder: String,
         colorPlaceholder: UIColor,
         textColor: UIColor,
         radius: CGFloat,
         borderColor: CGColor,
         borderWidth: CGFloat) {
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: titlePlaceholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: colorPlaceholder])
        self.textColor = textColor
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
