//
//  LoginView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit
import GoogleSignIn

protocol LoginScreenActionsProtocol: AnyObject {
    func didTapLogin(_ email: String, _ password: String)
    func didTapForgotPassword()
    func didTapRegister()
    func didTapSignInGoogle()
}

class LoginView: UIView {
    
    // MARK: - Properties
    private var isSecureTextEntry: Bool = false
    weak var delegateAction: LoginScreenActionsProtocol?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEyeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var iconStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [myBusinessImage, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var myBusinessImage: UIImageView = {
        let img = UIImageView()
        img.heightAnchor(36)
        img.widthAnchor(36)
        img.image = UIImage(named: Icon.iconApp.rawValue)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var titleLabel: BarberLabel = {
        let label = BarberLabel(text: "Meu negócio",
                                font: UIFont.boldSystemFont(ofSize: 20),
                                textColor: .darkGray)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        return label
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "E-mail cadastrado",
                                        colorPlaceholder: .lightGray,
                                        textColor: .black,
                                        radius: 5,
                                        borderColor: UIColor.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Senha",
                                        colorPlaceholder: .lightGray,
                                        textColor: .black,
                                        radius: 5,
                                        borderColor: UIColor.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        isSecureTextEntry: true)
        textField.setPaddingLeft()
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var loginButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Login",
                                  colorTitle: .darkGray,
                                  radius: 10,
                                  background: .systemGray)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [forgotPasswordLabel, forgotPasswordButton])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Esqueceu sua senha? "
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var forgotPasswordButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Clique aqui!",
                                        colorTitle: .darkGray,
                                        alignmentText: .left)
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "Ou"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var singInGoogleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signInGoogleImageView, signInGoogleButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.borderColor = UIColor.darkGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var signInGoogleImageView: UIImageView = {
        let container = UIImageView()
        container.image = UIImage(named: "ic_google")
        container.contentMode = .scaleAspectFit
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var signInGoogleButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Login com o google",
                                        colorTitle: .darkGray)
        button.addTarget(self, action: #selector(handlerSignInGoogleButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerStackView: UIStackView = {
        let container = UIStackView(arrangedSubviews: [registerLabel, registerButton])
        container.axis = .horizontal
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Não tem uma conta? "
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var registerButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Registre-se",
                                        colorTitle: .darkGray)
        button.addTarget(self, action: #selector(handlerRegisterButton), for: .touchUpInside)
        return button
    }()
    
    func isEnabledButtonLogin(_ isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = .BarberColors.lightBrown
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .systemGray
            loginButton.isEnabled = false
        }
    }
    
    // MARK: - Action TextFields
    @objc func textFieldEditingDidChange(sender: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let isValidLogin = email.isValidEmail() && password.count >= 7
        isValidLogin ? isEnabledButtonLogin(true) : isEnabledButtonLogin(false)
    }
        
    // MARK: - Action Buttons
    @objc
    func handleLoginButton() {
        loginButton.loadingIndicator(show: true)
        delegateAction?.didTapLogin(emailTextField.text ?? "", passwordTextField.text ?? "")
    }
    
    @objc
    func handleForgotPasswordButton() {
        delegateAction?.didTapForgotPassword()
    }
    
    @objc
    func handlerSignInGoogleButton() {
        delegateAction?.didTapSignInGoogle()
    }
    
    @objc
    func handlerRegisterButton() {
        delegateAction?.didTapRegister()
    }

    @objc
    func handleEyeButton() {
        if isSecureTextEntry {
            isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        } else {
            isSecureTextEntry = true
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
    }
    
}

extension LoginView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(iconStackView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(eyeButton)
        addSubview(loginButton)
        addSubview(forgotPasswordStackView)
        addSubview(orLabel)
        addSubview(singInGoogleStackView)
        addSubview(registerStackView)
    }
    
    func setupConstraints() {
        iconStackView
            .topAnchor(in: self, attribute: .top, padding: 110)
            .centerX(in: self)
            .heightAnchor(36)
        
        emailTextField
            .topAnchor(in: iconStackView, attribute: .bottom, padding: 50)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        passwordTextField
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        eyeButton
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 16)
            .rightAnchor(in: passwordTextField)
            .widthAnchor(48)
            .heightAnchor(48)
        
        loginButton
            .topAnchor(in: passwordTextField, attribute: .bottom, padding: 17)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        forgotPasswordStackView
            .topAnchor(in: loginButton, attribute: .bottom, padding: 14)
            .centerX(in: self)
        
        orLabel
            .topAnchor(in: forgotPasswordStackView, attribute: .bottom, padding: 20)
            .centerX(in: self)
        
        singInGoogleStackView
            .topAnchor(in: orLabel, attribute: .bottom, padding: 20)
            .centerX(in: self)
        
        registerStackView
            .bottomAnchor(in: self, attribute: .bottom, padding: 20)
            .centerX(in: self)
    }
    
    func setupConfiguration() {
        self.backgroundColor = .white
    }
}
