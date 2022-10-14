//
//  AddProcedureView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit
import FirebaseAuth

protocol AddProcedureActionsProtocol: AnyObject {
    func addProcedure(nameClient: String, typeProcedure: String, formPayment: String, value: String, email: String)
    func alertEmptyField()
}

class AddProcedureView: MNView {
    
    // MARK: - Properties
    weak var delegateActions: AddProcedureActionsProtocol?
    private let paymentMethods: [PaymentMethodType] = [.pix, .cash, .credit, .debit, .other]
    
    // MARK: - Init
    override init() {
        super.init()
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
    
    private lazy var subTitleLabel: BarberLabel = {
        let label = BarberLabel(text: "Preencha todos os campos abaixo para \n adicionar um novo procedimento.",
                                font: UIFont.systemFont(ofSize: 16),
                                textColor: .darkGray)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, typeJobTextField, paymentTextField, valueTextField])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        textField.heightAnchor(48)
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
        textField.heightAnchor(48)
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
        textField.heightAnchor(48)
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
        textField.heightAnchor(48)
        textField.delegate = self
        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var teste: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "R$",
            colorPlaceholder: .lightGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        textField.heightAnchor(48)
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
        let name = nameTextField.text.orEmpty
        let typeJob = typeJobTextField.text.orEmpty
        let payment = paymentTextField.text.orEmpty
        let value = valueTextField.text.orEmpty
        
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
            let amount = valueTextField.text?
                .replacingOccurrences(of: "R$", with: "")
                .dropFirst()
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: ".")
                .replacingOccurrences(of: " ", with: ".")

            delegateActions?.addProcedure(
                nameClient: nameTextField.text.orEmpty,
                typeProcedure: typeJobTextField.text.orEmpty,
                formPayment: paymentTextField.text.orEmpty,
                value: amount.orEmpty,
                email: email
            )
        }
    }
    
}
extension AddProcedureView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(gripView)
        addSubview(subTitleLabel)
        addSubview(containerStack)
        addSubview(addButton)
    }
    
    func setupConstraints() {
        
        gripView
            .topAnchor(in: self, padding: 10)
            .centerX(in: self)
            .heightAnchor(4)
            .widthAnchor(34)
        
        subTitleLabel
            .topAnchor(in: self, padding: 80)
            .centerX(in: self)
        
        containerStack
            .topAnchor(in: subTitleLabel, attribute: .bottom, padding: 30)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
    
        addButton
            .topAnchor(in: containerStack, attribute: .bottom, padding: 54)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
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
        let currentString = (textField.text.orEmpty) as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        if textField == valueTextField {
            maxLength = 13
        }
        if textField == typeJobTextField {
            maxLength = 28
        }
        return newString.count <= maxLength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
