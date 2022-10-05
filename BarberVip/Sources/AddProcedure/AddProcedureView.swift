//
//  AddProcedureView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit
import FirebaseAuth

protocol AddProcedureActionsProtocol: AnyObject {
    func addProcedure(nameClient: String, typeProcedure: String, formPayment: String, value: String, email: String)
    func alertEmptyField()
}

class AddProcedureView: UIView {
    
    // MARK: - Properties
    weak var delegateActions: AddProcedureActionsProtocol?
    private let paymentMethods: [PaymentMethodType] = [.pix, .cash, .credit, .debit, .other]
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode

    private lazy var pickerView = UIPickerView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .BarberColors.yellowDark
        $0.selectRow(2, inComponent: 0, animated: true)
    }

    private lazy var gripView = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGray
        $0.roundCorners(cornerRadius: 2)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subTitleLabel: BarberLabel = {
        let label = BarberLabel(text: "Preencha todos os campos abaixo para \n adicionar um novo procedimento.",
                                font: UIFont.systemFont(ofSize: 16),
                                textColor: .darkGray)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Nome do cliente",
            colorPlaceholder: .lightGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var typeJobTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Tipo de procedimento",
            colorPlaceholder: .lightGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var paymentTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Forma de pagamento",
            colorPlaceholder: .lightGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.delegate = self
        textField.inputView = pickerView
        return textField
    }()
    
    private lazy var valueTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "R$",
            colorPlaceholder: .lightGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        textField.delegate = self
        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        return textField
    }()

    lazy var addButton: CustomSubmitButton = {
        let button = CustomSubmitButton(
            title: "Adicionar",
            colorTitle: .BarberColors.darkGray,
            radius: 10,
            background: .BarberColors.lightBrown
        )
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods

    @objc
    private func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }

    private func isSomeEmptyField() -> Bool {
        var result: Bool = false
        let name = nameTextField.text ?? ""
        let typeJob = typeJobTextField.text ?? ""
        let payment = paymentTextField.text ?? ""
        let value = valueTextField.text ?? ""
        
        let someAreEmpty = name.isEmpty || typeJob.isEmpty || payment.isEmpty || value.isEmpty

        result = someAreEmpty ? true : false

        return result
    }
    
    // MARK: - Action Buttons
    @objc
    private func handleAddButton() {
        if isSomeEmptyField() {
            delegateActions?.alertEmptyField()
        } else {
            guard let email = Auth.auth().currentUser?.email else { return }
            let amount = valueTextField.text?.replacingOccurrences(of: "R$", with: "")
            delegateActions?.addProcedure(
                nameClient: nameTextField.text ?? "",
                typeProcedure: typeJobTextField.text ?? "",
                formPayment: paymentTextField.text ?? "",
                value: amount ?? "",
                email: email
            )
        }
    }
    
}
extension AddProcedureView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(scrollView)
        addSubview(gripView)
        scrollView.addSubview(contentView)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(typeJobTextField)
        contentView.addSubview(paymentTextField)
        contentView.addSubview(valueTextField)
        contentView.addSubview(addButton)
    }
    
    func setupConstraints() {
        
        gripView
            .topAnchor(in: self, padding: 10)
            .centerX(in: self)
            .heightAnchor(4)
            .widthAnchor(34)

        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(400)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: gripView.bottomAnchor, constant: 10),
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
        
        subTitleLabel
            .topAnchor(in: contentView, padding: 60)
            .centerX(in: contentView)
        
        nameTextField
            .topAnchor(in: subTitleLabel, attribute: .bottom, padding: 32)
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

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension AddProcedureView: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentMethods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paymentMethods[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentTextField.text = paymentMethods[row].rawValue
        paymentTextField.resignFirstResponder()
    }
}

extension AddProcedureView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int = 18
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        if textField == valueTextField {
            maxLength = 11
        }
        if textField == typeJobTextField {
            maxLength = 28
        }
        return newString.count <= maxLength
    }
}
