//
//  ProfileView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit

class ProfileView: UIView {
    
    var closed: Action?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "email")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var exiteButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "sair da conta", colorTitle: .white, background: .BarberColors.darkGray)
        button.addTarget(self, action: #selector(handleExiteButton), for: .touchUpInside)
        return button
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "versao 1.0.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Action Buttons
    
    @objc
    func handleExiteButton() {
        self.closed?()
    }
}

extension ProfileView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(emailLabel)
        addSubview(exiteButton)
        addSubview(versionLabel)
    }
    
    func setupConstraints() {
        emailLabel
            .topAnchor(in: self, attribute: .top, padding: 145)
            .centerX(in: self)
        
        exiteButton
            .bottomAnchor(in: versionLabel, attribute: .top, padding: 10)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        versionLabel
            .bottomAnchor(in: self, attribute: .bottom, padding: 10)
            .centerX(in: self)

    }
    
    func setupConfiguration() {
        backgroundColor = .BarberColors.lightBrown
    }
    
}
