//
//  ProcedureDetailView.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import UIKit

final class ProcedureDetailView: BottomSheetView {
    
    // MARK: - Actions properties
    private var procedure: GetProcedureModel?
    var didTapDelete: (String) -> Void?
 
    // MARK: - Init
    init(didTapDelete: @escaping (String) -> Void?) {
        self.didTapDelete = didTapDelete
        super.init(height: 410)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    
    lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
//        stack.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
//        stack.isLayoutMarginsRelativeArrangement = true
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var clientLabel: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        return container
    }()
    
    lazy var procedureLabel: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        return container
    }()
    
    lazy var paymentType: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        return container
    }()
    
    lazy var dateLabel: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        return container
    }()
    
    lazy var valueTotal: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        return container
    }()
    
    lazy var valueCosts: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        container.isHidden = true
        return container
    }()
    
    lazy var valueLiquid: TitleAndSubTitleView = {
        let container = TitleAndSubTitleView()
        container.isHidden = true
        return container
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
    
    // MARK: - Methods
    
    func setupView(procedure: GetProcedureModel) {
        self.procedure = procedure
        let amountLiquid = Double(procedure.valueLiquid ?? procedure.value) ?? 0.0
        let amountTotal = Double(procedure.value) ?? 0.0
        let amountCosts = Double(procedure.costs ?? .stringEmpty) ?? 0.0
        clientLabel.configureView(title: "Cliente:", subtitle: procedure.nameClient)
        procedureLabel.configureView(title: "Procedimento:", subtitle: procedure.typeProcedure)
        paymentType.configureView(title: "Metódo de pagamento:", subtitle: procedure.formPayment.rawValue)
        dateLabel.configureView(title: "Data:", subtitle: procedure.currentDate)
        valueTotal.configureView(title: "Valor recebido:", subtitle: amountTotal.plata.string(currency: .br))
        
        if procedure.costs != .stringEmpty && procedure.costs != nil {
            valueCosts.isHidden = false
            valueLiquid.isHidden = false
            valueLiquid.configureView(title: "Lucro:", subtitle: amountLiquid.plata.string(currency: .br))
            valueCosts.configureView(title: "Custos:", subtitle: amountCosts.plata.string(currency: .br))
        }
    }

    @objc
    private func didTapDeleteButton() {
        self.deleteButton.loadingIndicator(show: true)
        self.didTapDelete(procedure?._id ?? .stringEmpty)
    }
}

extension ProcedureDetailView: ViewCodeContract {
    
    func setupHierarchy() {
       
        baseView.addSubview(containerStack)
        
        containerStack.addArrangedSubview(clientLabel)
        containerStack.addArrangedSubview(procedureLabel)
        containerStack.addArrangedSubview(paymentType)
        containerStack.addArrangedSubview(dateLabel)
        containerStack.addArrangedSubview(valueTotal)
        containerStack.addArrangedSubview(valueCosts)
        containerStack.addArrangedSubview(valueLiquid)
        
        baseView.addSubview(deleteButton)
    }

    func setupConstraints() {
        
        containerStack
            .topAnchor(in: baseView, padding: 40)
            .leftAnchor(in: baseView, padding: 20)
            .rightAnchor(in: baseView, padding: 20)
        
        deleteButton
            .bottomAnchor(in: baseView, attribute: .bottom, padding: 8, layoutOption: .useSafeArea)
            .leftAnchor(in: baseView, padding: 20)
            .rightAnchor(in: baseView, padding: 20)
            .heightAnchor(45)
    }
}
