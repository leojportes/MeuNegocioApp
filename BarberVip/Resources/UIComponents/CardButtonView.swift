//
//  CardButtonView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/09/22.
//

import UIKit

class CardButtonView: UIView {

    init(icon: String, title: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.backgroundColor = .BarberColors.lightBrown
        iconView.image = UIImage(named: icon)
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "ic_help")
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}

extension CardButtonView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(iconView)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        iconView
            .topAnchor(in: self, padding: 20)
            .centerX(in: self)
            .heightAnchor(28)
            .widthAnchor(28)
        
        titleLabel
            .topAnchor(in: iconView, attribute: .bottom, padding: 10)
            .centerX(in: self)
    }
    
    
}
