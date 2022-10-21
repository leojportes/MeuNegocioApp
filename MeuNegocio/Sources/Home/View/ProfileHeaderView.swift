//
//  BarberNavBar.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: - Private properties
    private var openProfile: Action?
    
    // MARK: - Init    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Viewcode
    
    lazy var containerStackView: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.distribution = .fill
        container.spacing = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        tapGestureRecognizer()
        return container
    }()
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightText
        container.roundCorners(cornerRadius: 20)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var iconImage: BarberLabel = {
        let label = BarberLabel(font: UIFont.boldSystemFont(ofSize: 16))
        return label
    }()
    
    private lazy var nameUserLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconArrow: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: Icon.arrowDown.rawValue)
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
        
    @objc private func tappedView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.openProfile?()
        }
    }
    
    private func tapGestureRecognizer() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.tappedView))
        self.addGestureRecognizer(tapGR)
        self.isUserInteractionEnabled = true
    }
    
    func setupLayout(nameUser: String) {
        iconImage.text = "\(nameUser.prefix(2).uppercased())"
        nameUserLabel.text = "Olá, \(nameUser)"
    }
    
    func setupAction(actionButton: @escaping Action) {
        self.openProfile = actionButton
    }


}

extension ProfileHeaderView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(iconView)
        containerStackView.addArrangedSubview(nameUserLabel)
        containerStackView.addArrangedSubview(iconArrow)
        
        iconView.addSubview(iconImage)
    }
    
    func setupConstraints() {
        containerStackView
            .leftAnchor(in: self, padding: 16)
            .bottomAnchor(in: self, padding: 12)
            .heightAnchor(40)
        
        iconView
            .heightAnchor(40)
            .widthAnchor(40)
        
        iconImage
            .centerX(in: iconView)
            .centerY(in: iconView)
 
    
        iconArrow
            .heightAnchor(15)
            .widthAnchor(15)
    }
    
    func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
