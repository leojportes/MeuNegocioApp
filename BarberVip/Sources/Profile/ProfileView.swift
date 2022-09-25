//
//  ProfileView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit

class ProfileView: UIView {
    
    var closed: Action?
    var didTapVerifyEmail: Action?
    
    init(
        didTapClose: @escaping Action,
        didTapVerifyEmail: @escaping Action
    ) {
        self.closed = didTapClose
        self.didTapVerifyEmail = didTapVerifyEmail
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var headerCardView = UIView() .. {
        $0.backgroundColor = .BarberColors.yellowDark
        $0.roundCorners(cornerRadius: 15)
        $0.loadingIndicatorView(show: true)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var emailVerifiedLabel = UILabel() .. { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    private lazy var verifyEmailButton = UIButton() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.roundCorners(cornerRadius: 10)
        $0.backgroundColor = .clear
        $0.isHidden = true
        $0.setTitle("Verificar conta", for: .normal)
        $0.setTitleColor(.systemRed, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(didTapverifyEmailAction), for: .touchUpInside)
    }
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var exiteButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Sair da conta", colorTitle: .white, background: .BarberColors.darkGray)
        button.addTarget(self, action: #selector(handleExiteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Versao 1.0.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Action Buttons
    
    @objc
    func handleExiteButton() {
        self.closed?()
    }
    
    @objc
    func didTapverifyEmailAction() {
        self.didTapVerifyEmail?()
    }

    func setup(profileEmail: String, isEmailVerified: Bool) {
        userLabel.text = "Usuário: \(profileEmail.getUserPartOfEmail)"
        emailLabel.text = "E-mail cadastrado: \(profileEmail)"
        emailVerifiedLabel.text = isEmailVerified ? "E-mail verificado" : "E-mail não verificado"
        verifyEmailButton.isHidden = isEmailVerified
        headerCardView.loadingIndicatorView(show: false)
    }

}

extension ProfileView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(headerCardView)
        headerCardView.addSubview(userLabel)
        headerCardView.addSubview(emailLabel)
        headerCardView.addSubview(emailVerifiedLabel)
        headerCardView.addSubview(verifyEmailButton)
        addSubview(exiteButton)
        addSubview(versionLabel)
    }
    
    func setupConstraints() {
        headerCardView
            .topAnchor(in: self, padding: 50)
            .leftAnchor(in: self, padding: 15)
            .rightAnchor(in: self, padding: 15)
            .heightAnchor(150)

        userLabel
            .topAnchor(in: headerCardView, attribute: .top, padding: 15)
            .leftAnchor(in: headerCardView, padding: 15)

        emailLabel
            .topAnchor(in: userLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: headerCardView, padding: 15)
        
        emailVerifiedLabel
            .topAnchor(in: emailLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: headerCardView, padding: 15)
        
        verifyEmailButton
            .topAnchor(in: emailVerifiedLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: headerCardView, padding: 15)
            .widthAnchor(200)
            .heightAnchor(35)
        
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
