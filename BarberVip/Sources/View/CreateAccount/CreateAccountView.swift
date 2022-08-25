//
//  CreateAccountView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 15/08/22.
//

import UIKit

class CreateAccountView: UIView {
    
    var createAccount: ((String, String, String) -> Void)?
    var closedView: Action?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var closedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_arrowUp"), for: .normal)
        button.setTitleColor(UIColor.BarberColors.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlerClosedButton), for: .touchUpInside)
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
        label.textColor = .BarberColors.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "e-mail",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "senha",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        isSecureTextEntry: true)
        textField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var nameBarberShopTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "nome da barbearia",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5)
        textField.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var createAccountButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "CRIAR CONTA",
                                        colorTitle: .white,
                                  radius: 10,
                                  background: .systemGray)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleCreateAccountButton), for: .touchUpInside)
        return button
    }()
    
    func isEnabledButtonCreateAccount(_ isEnabled: Bool) {
        if isEnabled {
            createAccountButton.backgroundColor = .BarberColors.lightBrown
            createAccountButton.setTitleColor(.BarberColors.darkGray, for: .normal)
            createAccountButton.isEnabled = true
        }else {
            createAccountButton.backgroundColor = .systemGray
            createAccountButton.setTitleColor(.white, for: .normal)
            createAccountButton.isEnabled = false
        }
    }
    
    // MARK: - Action TextFields
    @objc
    func handleTextFieldDidChange(_ textField: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let nameBarber = nameBarberShopTextField.text else { return }
        
        
        if email.isValidEmail() && password.count > 7 && !nameBarber.isEmpty{
            isEnabledButtonCreateAccount(true)
        }else {
            isEnabledButtonCreateAccount(false)
        }
    }
    
    // MARK: - Action Buttons
    @objc
    func handlerClosedButton() {
        closedButton.setImage(UIImage(named: "ic_arrowDown"), for: .normal)
        closedView?()
    }
    
    @objc
    func handleCreateAccountButton() {
        print("conta criada com sucesso")
        createAccount?(emailTextField.text ?? "", passwordTextField.text ?? "", nameBarberShopTextField.text ?? "") 
    }
}

extension CreateAccountView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(closedButton)
        addSubview(barberImage)
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(nameBarberShopTextField)
        addSubview(createAccountButton)
    }
    
    func setupConstraints() {
        closedButton
            .topAnchor(in: self, attribute: .top, padding: 18)
            .rightAnchor(in: self, attribute: .right, padding: 20)
            .widthAnchor(24)
            .heightAnchor(24)
        
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
        
        nameBarberShopTextField
            .topAnchor(in: passwordTextField, attribute: .bottom, padding: 20)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        createAccountButton
            .bottomAnchor(in: self, attribute: .bottom, padding: 48)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
    }
    
    func setupConfiguration() {
        backgroundColor = .white
    }
    
}
