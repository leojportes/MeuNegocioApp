//
//  CardTotalView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 18/10/22.
//

import Foundation
import UIKit

class TotalReceiptCardView: CardView {
    
    // MARK: - Init
    init() {
        super.init()
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var totalLabel = BarberLabel(text: "Valor total recebido") .. {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .BarberColors.grayDescription
    }

    private(set) lazy var totalValueLabel = BarberLabel() .. {
        $0.text = "R$ 00,00"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }

    private lazy var proceduresLabel = BarberLabel() .. {
        $0.text = "Procedimentos"
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .BarberColors.grayDescription
    }

    private(set) lazy var proceduresValueLabel = BarberLabel() .. {
        $0.text = "0"
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    // MARK: Private methods
    func setupCardValues(totalValues: String?, procedureValue: String) {
        totalValueLabel.text = totalValues
        proceduresValueLabel.text = procedureValue
    }
}

extension TotalReceiptCardView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(totalLabel)
        addSubview(totalValueLabel)
        addSubview(proceduresLabel)
        addSubview(proceduresValueLabel)
    }
    
    func setupConstraints() {
        self
            .heightAnchor(80)
    
        totalLabel
            .topAnchor(in: self, padding: 20)
            .leftAnchor(in: self, padding: 20)
            .widthAnchor(150)

        totalValueLabel
            .topAnchor(in: totalLabel, attribute: .bottom, padding: 2)
            .leftAnchor(in: self, padding: 20)
            .widthAnchor(200)

        proceduresLabel
            .topAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .widthAnchor(150)

        proceduresValueLabel
            .topAnchor(in: proceduresLabel, attribute: .bottom, padding: 2)
            .rightAnchor(in: self, padding: 20)
            .widthAnchor(50)
    }
    
    func setupConfiguration() {
        self.loadingIndicatorView(show: true)
    }
}
