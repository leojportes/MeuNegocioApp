//
//  BarberNavBar.swift
//  BarberVip
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class ProfileHeaderView: UIStackView {
    
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
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightText
        container.roundCorners(cornerRadius: 20)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: Icon.profile.rawValue)
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
        nameUserLabel.text = nameUser
    }
    
    func setupAction(actionButton: @escaping Action) {
        self.openProfile = actionButton
    }


}

extension ProfileHeaderView: ViewCodeContract {
    func setupHierarchy() {
        addArrangedSubview(iconView)
        addArrangedSubview(nameUserLabel)
        addArrangedSubview(iconArrow)
        
        iconView.addSubview(iconImage)
    }
    
    func setupConstraints() {
        
        iconView
            .heightAnchor(40)
            .widthAnchor(40)
        
        iconImage
            .centerX(in: iconView)
            .centerY(in: iconView)
            .heightAnchor(20)
            .widthAnchor(20)
    
        iconArrow
            .heightAnchor(15)
            .widthAnchor(15)
    }
    
    func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        tapGestureRecognizer()
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 8
    }
}