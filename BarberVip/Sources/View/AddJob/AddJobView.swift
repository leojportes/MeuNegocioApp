//
//  AddJobView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit

class AddJobView: UIView {
    
    // MARK: - Properties
    var addJob: Action?
    var alertEmptyField: Action?
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    
    lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var barberImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "BarberImage")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "nome do cliente",
                                        colorPlaceholder: .systemGray,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var typeJobTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "tipo de procedimento",
                                        colorPlaceholder: .systemGray,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var paymentTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "forma de pagamento",
                                        colorPlaceholder: .systemGray,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var valueTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "R$",
                                        colorPlaceholder: .systemGray,
                                        textColor: .white,
                                        radius: 5,
                                        borderColor: UIColor.white.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .emailAddress)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var addButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "ADICIONAR",
                                        colorTitle: .white,
                                        radius: 10,
                                        background: .BarberColors.lightBrown)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods
    func setupAddJobView(addJob: @escaping Action,
                         alertEmptyField: @escaping Action) {
        self.addJob = addJob
        self.alertEmptyField = alertEmptyField
    }

    
    func isSomeEmptyField() -> Bool{
        var result: Bool = false
        let name = nameTextField.text ?? ""
        let typeJob = typeJobTextField.text ?? ""
        let payment = paymentTextField.text ?? ""
        let value = valueTextField.text ?? ""
        
        if name.isEmpty || typeJob.isEmpty || payment.isEmpty || value.isEmpty {
            result = true
        }else{
            result = false
        }
        return result
    }
    
    // MARK: - Action Buttons
    @objc
    func handleAddButton() {
        if isSomeEmptyField() {
            self.alertEmptyField?()
        }else{
            self.addJob?()
        }
    }
    
}
extension AddJobView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(barView)
        addSubview(barberImage)
        addSubview(nameTextField)
        addSubview(typeJobTextField)
        addSubview(paymentTextField)
        addSubview(valueTextField)
        addSubview(addButton)
    }
    
    func setupConstraints() {
        barView
            .topAnchor(in: self, attribute: .top, padding: 8)
            .centerX(in: self)
            .widthAnchor(40)
            .heightAnchor(10)
        
        barberImage
            .topAnchor(in: self, attribute: .top, padding: 54)
            .leftAnchor(in: self, attribute: .left, padding: 127)
            .rightAnchor(in: self, attribute: .right, padding: 127)
            .heightAnchor(66)
        
        nameTextField
            .topAnchor(in: barberImage, attribute: .bottom, padding: 50)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        typeJobTextField
            .topAnchor(in: nameTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        paymentTextField
            .topAnchor(in: typeJobTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        valueTextField
            .topAnchor(in: paymentTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
    
        addButton
            .topAnchor(in: valueTextField, attribute: .bottom, padding: 54)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
    }
    
    func setupConfiguration() {
        backgroundColor = .BarberColors.darkGray
    }
}
