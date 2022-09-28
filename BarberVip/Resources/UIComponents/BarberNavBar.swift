//
//  BarberNavBar.swift
//  BarberVip
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class BarberNavBar: UIView {
    
    // MARK: - Private properties
    private var openProfileModal: Action?
    
    // MARK: - Init    
    init(actionButton: @escaping Action, nameUser: String) {
        super.init(frame: .zero)
        self.openProfileModal = actionButton
        nameUserLabel.text = nameUser
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .red
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfile(_:)))
        container.addGestureRecognizer(tap)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightText
        container.roundCorners(cornerRadius: 20)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_profile")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
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
        img.image = UIImage(named: "ic_arrowDown")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    // MARK: - Actions private methods
    @objc private func didTapProfile(_ sender: UITapGestureRecognizer) {
        openProfileModal?()
        print("olá")
    }
}

extension BarberNavBar: ViewCodeContract {
    func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(nameUserLabel)
        containerView.addSubview(iconArrow)
        iconView.addSubview(iconImage)
    }
    
    func setupConstraints() {
        
        containerView
            .centerY(in: self)
            .leftAnchor(in: self, padding: 10)
            .heightAnchor(40)
            .widthAnchor(165)
        
        iconView
            .centerY(in: containerView)
            .leftAnchor(in: containerView, attribute: .left)
            .heightAnchor(40)
            .widthAnchor(40)
        
        iconImage
            .centerX(in: iconView)
            .centerY(in: iconView)
            .heightAnchor(20)
            .widthAnchor(20)
        
        nameUserLabel
            .centerY(in: containerView)
            .leftAnchor(in: iconView, attribute: .right, padding: 8)
        
        iconArrow
            .centerY(in: containerView)
            .leftAnchor(in: nameUserLabel, attribute: .right, padding: 4)
            .heightAnchor(15)
            .widthAnchor(15)
    }
}
