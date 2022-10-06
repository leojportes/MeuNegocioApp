//
//  PaymentTypeAmountCardView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 29/09/22.
//

import UIKit

final class PaymentTypeAmountCardView: CardView, ViewCodeContract {
    
    private lazy var debitAmountLabel = BarberLabel(text: "Débito") .. { $0.font = UIFont.boldSystemFont(ofSize: 15) }
    private lazy var creditAmountLabel = BarberLabel(text: "Crédito") .. { $0.font = UIFont.boldSystemFont(ofSize: 15) }
    private lazy var cashAmountLabel = BarberLabel(text: "Dinheiro") .. { $0.font = UIFont.boldSystemFont(ofSize: 15) }
    private lazy var pixAmountLabel = BarberLabel(text: "Pix") .. { $0.font = UIFont.boldSystemFont(ofSize: 15) }
    
    private lazy var debitAmountLabelValue = BarberLabel() .. {
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private lazy var creditAmountLabelValue = BarberLabel() .. {
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private lazy var cashAmountLabelValue = BarberLabel() .. {
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private lazy var pixAmountLabelValue = BarberLabel() .. {
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
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
    
    func setup(
        debitAmount: String = "R$00,00",
        creditAmount: String = "R$00,00",
        cashAmount: String = "R$00,00",
        pixAmount: String = "R$00,00"
    ) {
        debitAmountLabelValue.text = "\(debitAmount)"
        creditAmountLabelValue.text = "\(creditAmount)"
        cashAmountLabelValue.text = "\(cashAmount)"
        pixAmountLabelValue.text = "\(pixAmount)"
    }
    
    init() {
        super.init()
        self.backgroundColor = .white
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(debitAmountLabel)
        addSubview(debitAmountLabelValue)
        addSubview(separatorLine1)
        
        addSubview(creditAmountLabel)
        addSubview(creditAmountLabelValue)
        addSubview(separatorLine2)

        addSubview(cashAmountLabel)
        addSubview(cashAmountLabelValue)
        addSubview(separatorLine3)
        
        addSubview(pixAmountLabel)
        addSubview(pixAmountLabelValue)
        
    }
    
    func setupConstraints() {
        /// Debit
        debitAmountLabel
            .topAnchor(in: self, padding: 25)
            .leftAnchor(in: self, padding: 15)
            .heightAnchor(20)
        debitAmountLabelValue
            .topAnchor(in: self, padding: 25)
            .rightAnchor(in: self, padding: 15)
            .heightAnchor(20)
            .widthAnchor(100)
        separatorLine1
            .topAnchor(in: debitAmountLabel, attribute: .bottom, padding: 8)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(1)
    
        /// Credit
        creditAmountLabel
            .topAnchor(in: separatorLine1, attribute: .bottom, padding: 8)
            .leftAnchor(in: self, padding: 15)
            .heightAnchor(20)
        creditAmountLabelValue
            .topAnchor(in: separatorLine1, attribute: .bottom, padding: 8)
            .rightAnchor(in: self, padding: 15)
            .heightAnchor(20)
            .widthAnchor(100)
        separatorLine2
            .topAnchor(in: creditAmountLabelValue, attribute: .bottom, padding: 8)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(1)
    
        /// Cash
        cashAmountLabel
            .topAnchor(in: separatorLine2, attribute: .bottom, padding: 8)
            .leftAnchor(in: self, padding: 15)
            .heightAnchor(20)
        cashAmountLabelValue
            .topAnchor(in: separatorLine2, attribute: .bottom, padding: 8)
            .rightAnchor(in: self, padding: 15)
            .heightAnchor(20)
            .widthAnchor(100)
        separatorLine3
            .topAnchor(in: cashAmountLabelValue, attribute: .bottom, padding: 8)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(1)
    
        /// Pix
        pixAmountLabel
            .topAnchor(in: separatorLine3, attribute: .bottom, padding: 8)
            .leftAnchor(in: self, padding: 15)
            .heightAnchor(20)
        pixAmountLabelValue
            .topAnchor(in: separatorLine3, attribute: .bottom, padding: 8)
            .rightAnchor(in: self, padding: 15)
            .heightAnchor(20)
            .widthAnchor(100)
    }
    
}
