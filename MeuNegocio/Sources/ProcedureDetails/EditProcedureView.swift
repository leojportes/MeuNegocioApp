//
//  EditProcedureView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 17/01/23.
//

import Foundation
import UIKit

class EditProcedureView: MNView {
        
    private let paymentMethods: [PaymentMethodType] = [.pix, .cash, .credit, .debit, .other]
    var procedures: GetProcedureModel?
    
    override init() {
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(procedure: GetProcedureModel?) {
        nameTextField.text = procedure?.nameClient
        typeJobTextField.text = procedure?.typeProcedure
        paymentTextField.text = procedure?.formPayment.rawValue
        valueTextField.text = procedure?.value
        costsTextField.text = procedure?.costs
    }
    
    private lazy var pickerView = UIPickerView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .MNColors.yellowDark
        $0.selectRow(2, inComponent: 0, animated: true)
    }

    lazy var editingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Nome do cliente",
            colorPlaceholder: .lightGray,
            textColor: .MNColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.delegate = self
        textField.heightAnchor(48)
        return textField
    }()
    
    private lazy var typeJobTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Tipo de procedimento",
            colorPlaceholder: .lightGray,
            textColor: .MNColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.delegate = self
        textField.heightAnchor(48)
        return textField
    }()
    
    private lazy var paymentTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Forma de pagamento",
            colorPlaceholder: .lightGray,
            textColor: .MNColors.darkGray,
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
            textColor: .MNColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var costsTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "R$",
            colorPlaceholder: .lightGray,
            textColor: .MNColors.darkGray,
            radius: 5,
            borderColor: UIColor.systemGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        textField.delegate = self
        return textField
    }()
    
    lazy var addButton: CustomSubmitButton = {
        let button = CustomSubmitButton(
            title: "Salvar",
            colorTitle: .MNColors.darkGray,
            radius: 10,
            background: .MNColors.lightBrown
        )
        button.heightAnchor(48)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Actions
    @objc
    private func handleAddButton() {
        let model = UpdateProcedureModel(nameClient: nameTextField.text.orEmpty,
                                         typeProcedure: typeJobTextField.text.orEmpty,
                                         formPayment: paymentTextField.text.orEmpty,
                                         value: valueTextField.text.orEmpty,
                                         costs: valueTextField.text.orEmpty)
        print(model)
    }
}

extension EditProcedureView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(editingStack)
        editingStack.addArrangedSubview(nameTextField)
        editingStack.addArrangedSubview(typeJobTextField)
        editingStack.addArrangedSubview(paymentTextField)
        editingStack.addArrangedSubview(valueTextField)
        editingStack.addArrangedSubview(costsTextField)
        editingStack.addArrangedSubview(addButton)
    }

    func setupConstraints() {
        editingStack
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self)
        
        valueTextField
            .heightAnchor(48)
        
        costsTextField
            .heightAnchor(48)
    }
}
// MARK: - UITextFieldDelegate & UITextFieldDataSource

extension EditProcedureView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int = 18
        let currentString = (textField.text.orEmpty) as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        if textField == valueTextField {
            maxLength = 13
        }
        
        if textField == typeJobTextField {
            maxLength = 60
        }
        
        if textField == costsTextField {
            maxLength = 13
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


// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension EditProcedureView: UIPickerViewDelegate, UIPickerViewDataSource {

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

