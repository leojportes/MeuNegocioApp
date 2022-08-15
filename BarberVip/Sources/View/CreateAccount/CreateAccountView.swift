//
//  CreateAccountView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 15/08/22.
//

import UIKit

class CreateAccountView: UIView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
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
                                        borderWidth: 0.5)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "senha",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5)
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
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var createAccountButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "CRIAR CONTA",
                                        colorTitle: .BarberColors.darkGray,
                                  radius: 10,
                                  background: .BarberColors.lightBrown)
        button.addTarget(self, action: #selector(handleCreateAccountButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    func handleCreateAccountButton() {
        print("conta criada com sucesso")
    }
}

extension CreateAccountView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(barberImage)
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(nameBarberShopTextField)
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
