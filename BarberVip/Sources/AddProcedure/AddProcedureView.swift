//
//  AddProcedureView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit

protocol AddProcedureActionsProtocol: AnyObject {
    func addProcedure(nameClient: String, typeProcedure: String, formPayment: String, value: String)
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
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
        let textField = CustomTextField(
            titlePlaceholder: "Nome do cliente",
            colorPlaceholder: .systemGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.BarberColors.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var typeJobTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Tipo de procedimento",
            colorPlaceholder: .systemGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.BarberColors.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.setPaddingLeft()
        return textField
    }()
    
    lazy var paymentTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "Forma de pagamento",
            colorPlaceholder: .systemGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.BarberColors.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .default
        )
        textField.setPaddingLeft()
        textField.inputView = pickerView
        return textField
    }()
    
    lazy var valueTextField: CustomTextField = {
        let textField = CustomTextField(
            titlePlaceholder: "R$",
            colorPlaceholder: .systemGray,
            textColor: .BarberColors.darkGray,
            radius: 5,
            borderColor: UIColor.BarberColors.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .numberPad
        )
        textField.setPaddingLeft()
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
    func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }

    func isSomeEmptyField() -> Bool {
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
    func handleAddButton() {
        if isSomeEmptyField() {
            delegateActions?.alertEmptyField()
        } else {
            let amount = valueTextField.text?.replacingOccurrences(of: "R$", with: "")
            delegateActions?.addProcedure(
                nameClient: nameTextField.text ?? "",
                typeProcedure: typeJobTextField.text ?? "",
                formPayment: paymentTextField.text ?? "",
                value: amount ?? ""
            )
        }
    }
    
}
extension AddProcedureView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(scrollView)
        addSubview(gripView)
        scrollView.addSubview(contentView)
        contentView.addSubview(barberImage)
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

