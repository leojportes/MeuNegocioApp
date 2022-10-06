//
//  SubmitButton.swift
//  BarberVip
//
//  Created by Renilson Moreira on 13/08/22.
//

import Foundation
import UIKit

class CustomSubmitButton: UIButton {
    init(title: String,
         colorTitle: UIColor = .BarberColors.darkGray,
         radius: Int = 0,
         background: UIColor = .clear,
         alignmentText: ContentHorizontalAlignment = .center,
         borderColorCustom: CGColor = UIColor.clear.cgColor,
         borderWidthCustom: CGFloat = CGFloat(),
         fontSize: CGFloat = 18) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(colorTitle, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = background
        self.contentHorizontalAlignment = alignmentText
        self.layer.borderColor = borderColorCustom
        self.layer.borderWidth = borderWidthCustom
        self.titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
