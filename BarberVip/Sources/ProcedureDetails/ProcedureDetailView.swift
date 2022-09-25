//
//  ProcedureDetailView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 25/09/22.
//

import UIKit

final class ProcedureDetailView: BottomSheetView, ViewCodeContract {
    
    // MARK: - Actions properties
    private var procedure: GetProcedureModel?
    var didTapDelete: (String) -> Void?
 
    // MARK: - Init
    init(didTapDelete: @escaping (String) -> Void?) {
        self.didTapDelete = didTapDelete
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var paymentTypeIcon = UIImageView() .. {
        $0.image = UIImage(named: "ic_pix")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.text = "Cliente:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var procedureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.text = "Procedimento:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var procedureValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.text = "Valor recebido:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = .zero
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = 1
        label.text = "Método de pagamento:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var paymentMethodValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = 1
        label.text = "Data:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "redLight")
        button.setTitle("Deletar procedimento", for: .normal)
        button.setTitleColor(UIColor(named: "redDarkest"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.roundCorners(cornerRadius: 15)
        button.addTarget(nil, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        baseView.addSubview(nameLabel)
        baseView.addSubview(nameValueLabel)
        baseView.addSubview(procedureLabel)
        baseView.addSubview(procedureValueLabel)
        baseView.addSubview(paymentMethodLabel)
        baseView.addSubview(paymentMethodValueLabel)
        baseView.addSubview(paymentTypeIcon)
        baseView.addSubview(priceLabel)
        baseView.addSubview(priceValueLabel)
        baseView.addSubview(dateLabel)
        baseView.addSubview(dateValueLabel)
        baseView.addSubview(deleteButton)
    }

    func setupConstraints() {
        nameLabel
            .topAnchor(in: baseView, padding: 30)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(30)

        nameValueLabel
            .topAnchor(in: baseView, padding: 30)
            .leftAnchor(in: nameLabel, attribute: .right, padding: 10)
            .heightAnchor(30)
        
        procedureLabel
            .topAnchor(in: nameLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(30)
        
        procedureValueLabel
            .topAnchor(in: nameValueLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: procedureLabel, attribute: .right, padding: 10)
            .rightAnchor(in: baseView, padding: 5)
            .heightAnchor(30)
        
        paymentMethodLabel
            .topAnchor(in: procedureLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(30)

        paymentTypeIcon
            .topAnchor(in: procedureValueLabel, attribute: .bottom, padding: 8)
            .leftAnchor(in: paymentMethodLabel, attribute: .right, padding: 10)
            .heightAnchor(25)
            .widthAnchor(25)
        
        paymentMethodValueLabel
            .topAnchor(in: procedureValueLabel, attribute: .bottom, padding: 8)
            .leftAnchor(in: paymentTypeIcon, attribute: .right, padding: 5)
            .heightAnchor(25)
        
        priceLabel
            .topAnchor(in: paymentMethodLabel, attribute: .bottom, padding: 8)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(25)
        
        priceValueLabel
            .topAnchor(in: paymentMethodValueLabel, attribute: .bottom, padding: 11)
            .leftAnchor(in: priceLabel, attribute: .right, padding: 10)
            .heightAnchor(25)
        
        dateLabel
            .topAnchor(in: priceLabel, attribute: .bottom, padding: 8)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(25)
        
        dateValueLabel
            .topAnchor(in: priceValueLabel, attribute: .bottom, padding: 8)
            .leftAnchor(in: dateLabel, attribute: .right, padding: 10)
            .heightAnchor(25)
        
        deleteButton
            .bottomAnchor(in: baseView, padding: 40)
            .leftAnchor(in: baseView, padding: 10)
            .rightAnchor(in: baseView, padding: 10)
            .heightAnchor(45)
    }
    
    func setupConfiguration() {
        
    }
    
    func setupView(procedure: GetProcedureModel) {
        self.procedure = procedure
        nameValueLabel.text = procedure.nameClient
        procedureValueLabel.text = procedure.typeProcedure
        paymentMethodValueLabel.text = procedure.formPayment.rawValue
        priceValueLabel.text = "R$\(procedure.value)"
        dateValueLabel.text = procedure.currentDate
        setPaymentIcon(method: procedure.formPayment)
    }

    func setPaymentIcon(method: PaymentMethodType) {
        switch method {
        case .pix: paymentTypeIcon.image = UIImage(named: "ic_pix")
        case .cash: paymentTypeIcon.image = UIImage(named: "ic_cash")
        case .credit: paymentTypeIcon.image = UIImage(named: "ic_card")
        case .debit: paymentTypeIcon.image = UIImage(named: "ic_card")
        case .other: paymentTypeIcon.image = UIImage(named: "ic_cash") // WIP - Adicionar um ícone para .other
        }
    }

    @objc
    private func didTapDeleteButton() {
        self.deleteButton.loadingIndicator(show: true)
        self.didTapDelete(procedure?._id ?? "")
    }
}
