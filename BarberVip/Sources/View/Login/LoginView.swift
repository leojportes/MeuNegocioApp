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
                                        colorPlaceholder: .systemGray,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Senha",
                                        colorPlaceholder: .systemGray,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        isSecureTextEntry: true)
        textField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        textField.setPaddingLeft()
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
    
    lazy var forgotPasswordButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Esqueci a senha",
                                        colorTitle: .white,
                                        alignmentText: .left,
                                        fontSize: 16)
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Criar conta",
                                        colorTitle: .white,
                                        radius: 10,
                                        background: .BarberColors.darkGray,
                                        borderColorCustom: UIColor.white.cgColor,
                                        borderWidthCustom: 1)
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
    
    // MARK: - Action TextFields
    @objc
    func handleTextFieldDidChange(_ textField: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }        
        
        if email.isValidEmail() && password.count > 7 {
            isEnabledButtonLogin(true)
        }else {
            isEnabledButtonLogin(false)
        }
    }
        
    // MARK: - Action Buttons
    @objc
    func handleLoginButton() {
        delegateAction?.didTapLogin(emailTextField.text ?? "", passwordTextField.text ?? "")
    }
    
    @objc
    func handleForgotPasswordButton() {
        delegateAction?.didTapForgotPassword()
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
        }else {
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
        addSubview(loginButton)
        addSubview(forgotPasswordButton)
        addSubview(registerButton)
        addSubview(eyeButton)
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
        
        eyeButton
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 20)
            .rightAnchor(in: passwordTextField)
            .widthAnchor(48)
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
        
        registerButton
            .bottomAnchor(in: self, attribute: .bottom, padding: 48)
            .leftAnchor(in: self, attribute: .left, padding: 60)
            .rightAnchor(in: self, attribute: .right, padding: 60)
            .heightAnchor(40)
        
    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.darkGray
    }
}
