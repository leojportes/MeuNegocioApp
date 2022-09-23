//
//  AddJobView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit

protocol AddJobActionsProtocol: AnyObject {
    func addJob(nameClient: String, typeJob: String, typePayment: String, value: String)
    func alertEmptyField()
}

class AddJobView: UIView {
    
    // MARK: - Properties
    weak var delegateActions: AddJobActionsProtocol?
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gripView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
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
        let textField = CustomTextField(titlePlaceholder: "Nome do cliente",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .default)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var typeJobTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Tipo de procedimento",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .default)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var paymentTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "Forma de pagamento",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .default)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var valueTextField: CustomTextField = {
        let textField = CustomTextField(titlePlaceholder: "R$",
                                        colorPlaceholder: .systemGray,
                                        textColor: .BarberColors.darkGray,
                                        radius: 5,
                                        borderColor: UIColor.BarberColors.darkGray.cgColor,
                                        borderWidth: 0.5,
                                        keyboardType: .numberPad)
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var addButton: CustomSubmitButton = {
        let button = CustomSubmitButton(title: "Adicionar",
                                        colorTitle: .BarberColors.darkGray,
                                        radius: 10,
                                        background: .BarberColors.lightBrown)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods
    
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
            delegateActions?.alertEmptyField()
        }else{
            delegateActions?.addJob(nameClient: nameTextField.text ?? "",
                                    typeJob: typeJobTextField.text ?? "",
                                    typePayment: paymentTextField.text ?? "",
                                    value: valueTextField.text ?? "")
        }
    }
    
}
extension AddJobView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gripView)
        contentView.addSubview(barberImage)
        contentView.addSubview(nameTextField)
        contentView.addSubview(typeJobTextField)
        contentView.addSubview(paymentTextField)
        contentView.addSubview(valueTextField)
        contentView.addSubview(addButton)
    }
    
    func setupConstraints() {
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(400)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -160),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
         ])
        
        gripView
            .topAnchor(in: self, attribute: .top, padding: 11)
            .centerX(in: contentView)
            .widthAnchor(32)
            .heightAnchor(4)
        
        barberImage
            .topAnchor(in: contentView, attribute: .top, padding: 60)
            .leftAnchor(in: contentView, attribute: .left, padding: 127)
            .rightAnchor(in: contentView, attribute: .right, padding: 127)
            .heightAnchor(66)
        
        nameTextField
            .topAnchor(in: barberImage, attribute: .bottom, padding: 45)
            .leftAnchor(in: contentView, attribute: .left, padding: 16)
            .rightAnchor(in: contentView, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        typeJobTextField
            .topAnchor(in: nameTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: contentView, attribute: .left, padding: 16)
            .rightAnchor(in: contentView, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        paymentTextField
            .topAnchor(in: typeJobTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: contentView, attribute: .left, padding: 16)
            .rightAnchor(in: contentView, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        valueTextField
            .topAnchor(in: paymentTextField, attribute: .bottom, padding: 24)
            .leftAnchor(in: contentView, attribute: .left, padding: 16)
            .rightAnchor(in: contentView, attribute: .right, padding: 16)
            .heightAnchor(48)
    
        addButton
            .topAnchor(in: valueTextField, attribute: .bottom, padding: 54)
            .leftAnchor(in: contentView, attribute: .left, padding: 16)
            .rightAnchor(in: contentView, attribute: .right, padding: 16)
            .heightAnchor(48)
    }
    
    func setupConfiguration() {
        backgroundColor = .white
    }
}
