//
//  BarberLabel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 28/09/22.
//

import UIKit

class MNLabel: UILabel {
    
    init(
        text: String = "",
        font: UIFont = UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor = .MNColors.grayDarkest
    ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = font
        self.text = text
        self.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
