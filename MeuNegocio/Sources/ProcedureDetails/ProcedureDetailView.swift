//
//  ProcedureDetailView.swift
//  MeuNegocio
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
        super.init(height: 380)
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
  
    /// Client
    private lazy var clientLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDarkest
        $0.numberOfLines = .zero
        $0.text = "Cliente:"
    }

    private lazy var clientValueLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDescription
        $0.numberOfLines = .zero
        $0.textAlignment = .right
        $0.text = "Leonardo Portes"
    }

    /// Procedure
    private lazy var procedureLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDarkest
        $0.numberOfLines = .zero
        $0.text = "Procedimento:"
    }

    private lazy var procedureValueLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDescription
        $0.numberOfLines = .zero
        $0.textAlignment = .right
    }
    
    ///  Payment method
    private lazy var paymentMethodLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDarkest
        $0.numberOfLines = .zero
        $0.text = "Método de pagamento:"
    }

    private lazy var paymentMethodValueLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDescription
        $0.numberOfLines = .zero
        $0.textAlignment = .right
    }
    
    /// Date
    private lazy var dateLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDarkest
        $0.numberOfLines = .zero
        $0.text = "Data:"
    }

    private lazy var dateValueLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDescription
        $0.numberOfLines = .zero
        $0.textAlignment = .right
    }
    
    /// Amount
    ///
    private lazy var amountLabel = BarberLabel() .. {
    $0.font = UIFont.boldSystemFont(ofSize: 16)
    $0.textColor = .BarberColors.grayDarkest
    $0.numberOfLines = .zero
    $0.text = "Valor recebido:"
}
    private lazy var amountValueLabel = BarberLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .BarberColors.grayDescription
        $0.numberOfLines = .zero
        $0.text = "R$00,00"
    }
    
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
    
    private lazy var separatorLine1 = UIView() .. {
        $0.backgroundColor = .BarberColors.lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var separatorLine2 = UIView() .. {
        $0.backgroundColor = .BarberColors.lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var separatorLine3 = UIView() .. {
        $0.backgroundColor = .BarberColors.lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var separatorLine4 = UIView() .. {
        $0.backgroundColor = .BarberColors.lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
       
        baseView.addSubview(clientLabel)
        baseView.addSubview(clientValueLabel)
        baseView.addSubview(separatorLine1)
        baseView.addSubview(procedureLabel)
        baseView.addSubview(procedureValueLabel)
        baseView.addSubview(separatorLine2)

        baseView.addSubview(paymentMethodLabel)
        baseView.addSubview(paymentMethodValueLabel)
        baseView.addSubview(separatorLine3)

        baseView.addSubview(dateLabel)
        baseView.addSubview(dateValueLabel)
        baseView.addSubview(separatorLine4)

        baseView.addSubview(amountLabel)
        baseView.addSubview(amountValueLabel)
        baseView.addSubview(deleteButton)
    }

    func setupConstraints() {
       
        clientLabel
            .topAnchor(in: baseView, padding: 40)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        clientValueLabel
            .topAnchor(in: baseView, padding: 40)
            .leftAnchor(in: clientLabel, attribute: .right, padding: 5)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
        
        separatorLine1
            .topAnchor(in: clientLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(1)
        
        procedureLabel
            .topAnchor(in: separatorLine1, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        procedureValueLabel
            .topAnchor(in: separatorLine1, attribute: .bottom, padding: 10)
            .leftAnchor(in: procedureLabel, attribute: .right, padding: 5)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
        
        separatorLine2
            .topAnchor(in: procedureLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(1)
    
        paymentMethodLabel
            .topAnchor(in: separatorLine2, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
            .widthAnchor(190)
        
        paymentMethodValueLabel
            .topAnchor(in: separatorLine2, attribute: .bottom, padding: 10)
            .widthAnchor(100)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
        
        separatorLine3
            .topAnchor(in: paymentMethodLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(1)
    
        dateLabel
            .topAnchor(in: separatorLine3, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        dateValueLabel
            .topAnchor(in: separatorLine3, attribute: .bottom, padding: 10)
            .leftAnchor(in: dateLabel, attribute: .right, padding: 5)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
        
        separatorLine4
            .topAnchor(in: dateLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(1)
        
        amountLabel
            .topAnchor(in: separatorLine4, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        amountValueLabel
            .topAnchor(in: separatorLine4, attribute: .bottom, padding: 10)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(18)
        
        deleteButton
            .bottomAnchor(in: baseView, padding: 30)
            .leftAnchor(in: baseView, padding: 10)
            .rightAnchor(in: baseView, padding: 10)
            .heightAnchor(45)
    }
    
    func setupView(procedure: GetProcedureModel) {
        self.procedure = procedure
        clientValueLabel.text = procedure.nameClient
        procedureValueLabel.text = procedure.typeProcedure
        paymentMethodValueLabel.text = procedure.formPayment.rawValue
        amountValueLabel.text = "R$\(procedure.value)"
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
        self.didTapDelete(procedure?._id ?? .stringEmpty)
    }
}
