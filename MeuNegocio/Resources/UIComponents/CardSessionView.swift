//
//  CardSessionView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 13/10/22.
//

import UIKit

class CardSessionView: UIView {
    init(icon: String, title: String, titleColor: UIColor, isHiddenArrow: Bool = true) {
        super.init(frame: .zero)
        iconImageView.image = UIImage(named: icon)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        iconArrow.isHidden = isHiddenArrow
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconImageView: UIImageView = {
        let container = UIImageView()
        container.contentMode = .scaleAspectFit
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var iconArrow: UIImageView = {
        let container = UIImageView()
        container.image = UIImage(named: Icon.arrowRight.rawValue)
        container.contentMode = .scaleAspectFit
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
}

extension CardSessionView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(iconArrow)
    }
    
    func setupConstraints() {
        iconImageView
            .topAnchor(in: self)
            .bottomAnchor(in: self)
            .leftAnchor(in: self)
            .heightAnchor(24)
            .widthAnchor(24)
        
        titleLabel
            .leftAnchor(in: iconImageView, attribute: .right, padding: 8)
            .rightAnchor(in: self)
            .centerY(in: iconImageView)
        
        iconArrow
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(20)
            .widthAnchor(20)
            .centerY(in: iconImageView)
    }
    
    func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
