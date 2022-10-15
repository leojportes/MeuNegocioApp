//
//  ProfileView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit
import FirebaseAuth

class ProfileView: UIView {
    
    // MARK: - Action Properties
    var logout: Action?
    var deleteAccount: Action?
    
    // MARK: - Properties
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var user: UserModel? {
        didSet {
            guard let user = user else { return }
            nameUserLabel.text = user.name
            emailLabel.text = user.email
            companyLabel.text = "Empresa: \(user.barbershop)"
            cityLabel.text = user.city + "/" + user.state
            InfoStackView.loadingIndicatorView(show: false)
        }
    }
    
    // MARK: - Init

    init(
        didTapLogout: @escaping Action,
        didTapdeleteAccount: @escaping Action
    ) {
        self.logout = didTapLogout
        self.deleteAccount = didTapdeleteAccount
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewCode
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .BarberColors.lightBrown
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
    
    lazy var InfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [companyLabel, cityLabel, emailLabel])
        stack.backgroundColor = .BarberColors.lightGray
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
    
    lazy var companyLabel: BarberLabel = {
        let label = BarberLabel(font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    lazy var cityLabel: BarberLabel = {
        let label = BarberLabel(font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    private lazy var emailLabel: BarberLabel = {
        let label = BarberLabel(font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    private lazy var logoutAccount: CardSessionView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleLogout))
        let view = CardSessionView(icon: Icon.logoutAccount.rawValue,
                                   title: "Sair do aplicativo",
                                   titleColor: .black,
                                   isHiddenArrow: false)
        view.layer.borderColor = UIColor.BarberColors.lightGray.cgColor
        view.layer.borderWidth = 1.5
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var deleteAccountButton: CardSessionView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDeleteAccount))
        let view = CardSessionView(icon: Icon.deleteAccount.rawValue,
                                   title: "Encerrar conta",
                                   titleColor: .black,
                                   isHiddenArrow: false)
        view.layer.borderColor = UIColor.BarberColors.lightGray.cgColor
        view.layer.borderWidth = 1.5
        view.addGestureRecognizer(tap)
        return view
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
    func handleLogout() {
        self.logout?()
    }
    
    @objc
    func handleDeleteAccount() {
        self.deleteAccount?()
    }
}

extension ProfileView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(iconView)
        iconView.addSubview(iconImage)
        addSubview(nameUserLabel)
        addSubview(InfoStackView)
        addSubview(deleteAccountButton)
        addSubview(logoutAccount)
        addSubview(versionLabel)
    }
    
    func setupConstraints() {

        iconView
            .topAnchor(in: self, padding: 70)
            .leftAnchor(in: self, padding: 16)
            .heightAnchor(60)
            .widthAnchor(60)
        
        iconImage
            .centerX(in: iconView)
            .centerY(in: iconView)
            .heightAnchor(24)
            .widthAnchor(24)
        
        nameUserLabel
            .leftAnchor(in: iconView, attribute: .right, padding: 12)
            .centerY(in: iconView)

        InfoStackView
            .topAnchor(in: iconView, attribute: .bottom, padding: 40)
            .leftAnchor(in: self, attribute: .left, padding: 14)
            .rightAnchor(in: self, attribute: .right, padding: 14)
            .heightAnchor(80)
        
        logoutAccount
            .topAnchor(in: InfoStackView, attribute: .bottom, padding: 46)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(56)
        
        deleteAccountButton
            .topAnchor(in: logoutAccount, attribute: .bottom)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(55)
        
        versionLabel
            .bottomAnchor(in: self, attribute: .bottom, padding: 10)
            .centerX(in: self)

    }
    
    func setupConfiguration() {
        backgroundColor = .white
    }
    
}
