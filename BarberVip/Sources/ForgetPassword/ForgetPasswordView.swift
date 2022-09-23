//
//  ForgetPasswordView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import Foundation

import UIKit

final class ForgetPasswordView: UIView {
    
    private var didTapResetAction: (String) -> Void?
    
    // MARK: - Init
    init(didTapResetAction: @escaping (String) -> Void?) {
        self.didTapResetAction = didTapResetAction
        super.init(frame: .zero)
        setupView()
    }

    private lazy var gripView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var barberImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "BarberImage")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "E-mail cadastrado",
                                        colorPlaceholder: .darkGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var resetPasswordButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Redefinir",
                                  colorTitle: .white,
                                  radius: 10,
                                  background: .systemGray)
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
        return button
    }()

    private func isEnabledButtonLogin(_ isEnabled: Bool) {
        if isEnabled {
            resetPasswordButton.backgroundColor = .darkGray
            resetPasswordButton.isEnabled = true
        } else {
            resetPasswordButton.backgroundColor = .systemGray
            resetPasswordButton.isEnabled = false
        }
    }
    
    // MARK: - Action TextFields
    @objc func textFieldEditingDidChange(sender: UITextField) {
        guard let email = emailTextField.text else { return }
        let isValidEmail = email.isValidEmail()
        isValidEmail ? isEnabledButtonLogin(true) : isEnabledButtonLogin(false)
    }
    
    @objc
    private func didTapReset() {
        guard let emailText = emailTextField.text else { return }
        self.didTapResetAction(emailText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForgetPasswordView: ViewCodeContract {

    func setupHierarchy() {
        addSubview(gripView)
        addSubview(barberImage)
        addSubview(emailTextField)
        addSubview(resetPasswordButton)
    }
    
    func setupConstraints() {
        gripView
            .topAnchor(in: self, attribute: .top, padding: 11)
            .centerX(in: self)
            .widthAnchor(32)
            .heightAnchor(4)
        
        barberImage
            .topAnchor(in: gripView, attribute: .bottom, padding: 60)
            .centerX(in: gripView)
            .heightAnchor(66)
            .widthAnchor(66)
        
        emailTextField
            .topAnchor(in: barberImage, attribute: .bottom, padding: 45)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)

        resetPasswordButton
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 54)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
    }

    func setupConfiguration() {
        backgroundColor = .BarberColors.lightBrown
    }
    
}
