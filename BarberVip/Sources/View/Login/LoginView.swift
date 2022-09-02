//
//  LoginView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit

protocol LoginScreenActionsProtocol: AnyObject {
    func didTapLogin(_ email: String, _ password: String)
    func didTapForgotPassword()
    func didTapRegister()
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
        let textField = CustomTextField(titlePlaceholder: "E-mail cadastrado",
                                        colorPlaceholder: .systemGray3,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Senha",
                                        colorPlaceholder: .systemGray3,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        isSecureTextEntry: true)
        textField.setPaddingLeft()
        textField.delegate = self
        return textField
    }()
    
    lazy var loginButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Login",
                                  colorTitle: .white,
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
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var forgotPasswordButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Clique aqui!",
                                        colorTitle: .white,
                                        alignmentText: .left)
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "Ou"
        label.textColor = .systemGray3
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
        stack.layer.borderColor = UIColor.white.cgColor
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
                                        colorTitle: .white)
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
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var registerButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Registre-se",
                                        colorTitle: .white,
                                        background: .BarberColors.darkGray)
        button.addTarget(self, action: #selector(handlerRegisterButton), for: .touchUpInside)
        return button
    }()
    
    func isEnabledButtonLogin(_ isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = .BarberColors.lightBrown
            loginButton.setTitleColor(.BarberColors.darkGray, for: .normal)
            loginButton.isEnabled = true
        }else {
            loginButton.backgroundColor = .systemGray
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.isEnabled = false
        }
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
        print("google")
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
        addSubview(titleLabel)
        addSubview(barberImage)
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
        barberImage
            .topAnchor(in: self, attribute: .top, padding: 54)
            .leftAnchor(in: self, attribute: .left, padding: 127)
            .rightAnchor(in: self, attribute: .right, padding: 127)
            .heightAnchor(66)
        
        titleLabel
            .topAnchor(in: barberImage, attribute: .bottom)
            .centerX(in: self)
        
        emailTextField
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 50)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        passwordTextField
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 16)
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
        self.backgroundColor = UIColor.BarberColors.darkGray
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let isValidLogin = email.isValidEmail() && password.count > 7
        isValidLogin ? isEnabledButtonLogin(true) : isEnabledButtonLogin(false)
    }
}
