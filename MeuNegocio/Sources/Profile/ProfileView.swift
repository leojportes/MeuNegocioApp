//
//  ProfileView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit
import FirebaseAuth

class ProfileView: UIView {
    
    // MARK: - Action Properties
    var logout: Action?
    var closedView: Action?
    var didTapVerifyEmail: Action?
    
    // MARK: - Properties
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var user: UserModel? {
        didSet {
            guard let user = user else { return }
            nameUserLabel.text = user.name
            emailLabel.text = user.email
            nameBarberLabel.text = "Barbearia: \(user.barbershop)"
            cityLabel.text = user.city + "/" + user.state
            InfoStackView.loadingIndicatorView(show: false)
        }
    }
    
    // MARK: - Init

    init(
        didTapLogout: @escaping Action,
        didTapClosedView: @escaping Action,
        didTapVerifyEmail: @escaping Action
    ) {
        self.logout = didTapLogout
        self.closedView = didTapClosedView
        self.didTapVerifyEmail = didTapVerifyEmail
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewCode
    lazy var closedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Icon.closed.rawValue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapClosed), for: .touchUpInside)
        return button
    }()
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightText
        container.roundCorners(cornerRadius: 30)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var InfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameBarberLabel, cityLabel, emailVerifiedLabel])
        stack.backgroundColor = .BarberColors.yellowDark
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.roundCorners(cornerRadius: 10)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.loadingIndicatorView(show: true)
        return stack
    }()
    
    lazy var nameBarberLabel: BarberLabel = {
        let label = BarberLabel(font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    lazy var cityLabel: BarberLabel = {
        let label = BarberLabel(font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    private lazy var emailVerifiedLabel = UILabel() .. {
        let isEmailVerified = Current.shared.isEmailVerified
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.text = isEmailVerified ? "E-mail verificado" : "E-mail não verificado"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var verifyEmailButton = UIButton() .. {
        let isEmailVerified = Current.shared.isEmailVerified
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.roundCorners(cornerRadius: 10)
        $0.isHidden = isEmailVerified
        $0.setImage(UIImage(named: Icon.arrowRight.rawValue), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        $0.setTitle("Verificar conta", for: .normal)
        $0.setTitleColor(.systemRed, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(didTapverifyEmailAction), for: .touchUpInside)
    }
    
    private lazy var exiteButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Sair da conta", colorTitle: .white, background: .BarberColors.darkGray)
        button.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        if let version = appVersion {
            label.text = "Versão \(version)"
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Action Buttons
    @objc
    func didTapClosed() {
        self.closedView?()
    }
    
    @objc
    func handleLogoutButton() {
        self.logout?()
    }
    
    @objc
    func didTapverifyEmailAction() {
        self.didTapVerifyEmail?()
    }

}

extension ProfileView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(closedButton)
        addSubview(iconView)
        iconView.addSubview(iconImage)
        addSubview(nameUserLabel)
        addSubview(emailLabel)
        addSubview(InfoStackView)
        addSubview(verifyEmailButton)
        addSubview(exiteButton)
        addSubview(versionLabel)
    }
    
    func setupConstraints() {
        
        closedButton
            .topAnchor(in: self, padding: 30)
            .rightAnchor(in: self, padding: 15)
            .heightAnchor(18)
            .widthAnchor(18)

        iconView
            .topAnchor(in: self, padding: 70)
            .centerX(in: self)
            .heightAnchor(60)
            .widthAnchor(60)
        
        iconImage
            .centerX(in: iconView)
            .centerY(in: iconView)
            .heightAnchor(24)
            .widthAnchor(24)
        
        nameUserLabel
            .topAnchor(in: iconView, attribute: .bottom, padding: 25)
            .centerX(in: self)

        emailLabel
            .topAnchor(in: nameUserLabel, attribute: .bottom, padding: 4)
            .centerX(in: self)

        InfoStackView
            .topAnchor(in: emailLabel, attribute: .bottom, padding: 20)
            .leftAnchor(in: self, attribute: .left, padding: 14)
            .rightAnchor(in: self, attribute: .right, padding: 14)
            .heightAnchor(80)
        
        verifyEmailButton
            .topAnchor(in: InfoStackView, attribute: .bottom, padding: 18)
            .leftAnchor(in: self, padding: 14)
            .widthAnchor(170)
            .heightAnchor(25)
        
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
