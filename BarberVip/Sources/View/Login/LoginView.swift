//
//  LoginView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    // MARK: - Properties
    var navigateToHome: Action?
    var navigateToCreateAccount: Action?
    var navigateToForgotPassword: Action?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var barberImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "BarberImage")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Barber shop"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "e-mail cadastrado",
                                          colorPlaceholder: .white,
                                          textColor: .white,
                                          radius: 5,
                                          borderColor: UIColor.white.cgColor,
                                          borderWidth: 0.5)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "senha",
                                          colorPlaceholder: .white,
                                          textColor: .white,
                                          radius: 5,
                                          borderColor: UIColor.white.cgColor,
                                          borderWidth: 0.5)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var loginButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "LOGIN",
                                  colorTitle: .white,
                                  radius: 10,
                                  background: .BarberColors.lightBrown)
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "esqueci a senha",
                                  colorTitle: .white,
                                  alignmentText: .left)
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var createAccountButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "CADASTRE-SE",
                                  colorTitle: .white,
                                  radius: 10,
                                  background: .BarberColors.darkGray)
        button.addTarget(self, action: #selector(handleCreateAccountButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    func handleLoginButton() {
        self.navigateToHome?()
    }
    
    @objc
    func handleForgotPasswordButton() {
        self.navigateToForgotPassword?()
    }
    
    @objc
    func handleCreateAccountButton() {
        self.navigateToCreateAccount?()
    }
    
    
    // MARK: - Methods
    func setupHomeView(navigateToHome: @escaping Action,
                       navigateToForgotPassword: @escaping Action,
                       navigateToCreateAccount: @escaping Action) {
        self.navigateToHome = navigateToHome
        self.navigateToForgotPassword = navigateToForgotPassword
        self.navigateToCreateAccount = navigateToCreateAccount
    }
    
}

extension LoginView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(barberImage)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(forgotPasswordButton)
        addSubview(createAccountButton)
    }
    
    func setupConstraints() {
        barberImage
            .topAnchor(in: self, attribute: .top, padding: 54)
            .leftAnchor(in: self, attribute: .left, padding: 127)
            .rightAnchor(in: self, attribute: .right, padding: 127)
            .heightAnchor(66)
        
        titleLabel
            .topAnchor(in: barberImage, attribute: .bottom)
            .centerX(in: self)
        
        emailTextField
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 70)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        passwordTextField
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 20)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        loginButton
            .topAnchor(in: passwordTextField, attribute: .bottom, padding: 46)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        forgotPasswordButton
            .topAnchor(in: loginButton, attribute: .bottom, padding: 14)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 133)
            .heightAnchor(22)
        
        createAccountButton
            .bottomAnchor(in: self, attribute: .bottom, padding: 48)
            .leftAnchor(in: self, attribute: .left, padding: 60)
            .rightAnchor(in: self, attribute: .right, padding: 60)
            .heightAnchor(40)
        
    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.darkGray
    }
}
