//
//  UserOnboardingView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 30/09/22.
//

import UIKit
import FirebaseAuth

protocol CreateUserOnboardingProtocol: AnyObject {
    func addUserOnboarding(model: CreateUserModel)
    func alertEmptyField()
}

class UserOnboardingView: UIView {

    // MARK: - Properties
    weak var delegate: CreateUserOnboardingProtocol?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: BarberLabel = {
        let label = BarberLabel(text: "Olá, seja bem-vindo(a)!",
                                font: UIFont.boldSystemFont(ofSize: 28),
                                textColor: .darkGray)
        label.textAlignment = .center
        return label
    }()
    
    lazy var subTitleLabel: BarberLabel = {
        let label = BarberLabel(text: "Preencha os dados abaixo para \n personalizarmos a sua experiência.",
                                font: UIFont.systemFont(ofSize: 16),
                                textColor: .lightGray)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, barbershopTextField, cityTextField, stateTextField])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Digite seu nome",
                                        colorPlaceholder: .lightGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.systemGray.cgColor,
                                        borderWidth: 0.5)
        textField.heightAnchor(48)
        textField.setPaddingLeft()
        return textField
    }()
    
    
    lazy var barbershopTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Digite o nome da barbearia",
                                        colorPlaceholder: .lightGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.systemGray.cgColor,
                                        borderWidth: 0.5)
        textField.heightAnchor(48)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var cityTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Digite o nome da sua cidade",
                                        colorPlaceholder: .lightGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.systemGray.cgColor,
                                        borderWidth: 0.5)
        textField.heightAnchor(48)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var stateTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Digite o nome da seu estado, ex: SC",
                                        colorPlaceholder: .lightGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.systemGray.cgColor,
                                        borderWidth: 0.5)
        textField.heightAnchor(48)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var continueButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Continuar",
                                        radius: 10,
                                        background: .BarberColors.lightBrown)
        button.addTarget(self, action: #selector(handleButtonContinue), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    func isSomeEmptyField() -> Bool {
        var result: Bool = false
        let name = nameTextField.text ?? ""
        let typeJob = barbershopTextField.text ?? ""
        let payment = cityTextField.text ?? ""
        let value = stateTextField.text ?? ""
        
        let someAreEmpty = name.isEmpty || typeJob.isEmpty || payment.isEmpty || value.isEmpty

        result = someAreEmpty ? true : false

        return result
    }
    
    @objc func handleButtonContinue() {
    
        if isSomeEmptyField() {
            delegate?.alertEmptyField()
        } else {
            guard let email = Auth.auth().currentUser?.email else { return }
            delegate?.addUserOnboarding(model: CreateUserModel(name: nameTextField.text ?? "",
                                                                      barbershop: barbershopTextField.text ?? "",
                                                                      city: cityTextField.text ?? "",
                                                                      state: stateTextField.text ?? "",
                                                                      email: email))
        }
         
    }
    
}

extension UserOnboardingView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(containerStack)
        addSubview(continueButton)
    }
    
    func setupConstraints() {
        
        titleLabel
            .topAnchor(in: self, attribute: .top, padding: 90)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
        
        subTitleLabel
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 16)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
        
        containerStack
            .topAnchor(in: subTitleLabel, attribute: .bottom, padding: 30)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
        
        continueButton
            .topAnchor(in: containerStack, attribute: .bottom, padding: 48)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
    }
    
    func setupConfiguration() {
        backgroundColor = .white
    }
    
    
}
