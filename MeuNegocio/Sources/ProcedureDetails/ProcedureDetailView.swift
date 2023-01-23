//
//  ProcedureDetailView.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import UIKit

final class ProcedureDetailView: UIView {
    
    // MARK: - Actions properties
    private var procedure: GetProcedureModel?
    var didTapDelete: (String) -> Void?
    var valuesUpdate: (GetProcedureModel) -> Void?
 
    // MARK: - Init
    init(didTapDelete: @escaping (String) -> Void?, valuesUpdate: @escaping (GetProcedureModel) -> Void?) {
        self.didTapDelete = didTapDelete
        self.valuesUpdate = valuesUpdate
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    
    lazy var detailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
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
    
    lazy var editingContainer: EditProcedureView = {
        let container = EditProcedureView { self.valuesUpdate($0) }
        container.isHidden = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .MNColors.blueEdit
        button.setTitle("Editar", for: .normal)
        button.setTitleColor(.MNColors.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.roundCorners(cornerRadius: 15)
        button.addTarget(nil, action: #selector(didTapEditButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Deletar", for: .normal)
        button.setTitleColor(.MNColors.lightGray, for: .normal)
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
    
    func updated(_ result: Bool) {
        if result {
            detailsStack.isHidden = false
            editingContainer.isHidden = true
            buttonsStack.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.detailsStack.loadingIndicatorView(show: false)
            })
        }
    }

    @objc
    private func didTapEditButton() {
        editingContainer.setValues(procedure: procedure)
        detailsStack.isHidden = true
        editingContainer.isHidden = false
        buttonsStack.isHidden = true
        detailsStack.loadingIndicatorView(show: true)
    }
    
    @objc
    private func didTapDeleteButton() {
        self.deleteButton.loadingIndicator(show: true)
        self.didTapDelete(procedure?._id ?? .stringEmpty)
    }

}

extension ProcedureDetailView: ViewCodeContract {
    
    func setupHierarchy() {
        addSubview(detailsStack)
        detailsStack.addArrangedSubview(clientLabel)
        detailsStack.addArrangedSubview(procedureLabel)
        detailsStack.addArrangedSubview(paymentType)
        detailsStack.addArrangedSubview(dateLabel)
        detailsStack.addArrangedSubview(valueTotal)
        detailsStack.addArrangedSubview(valueCosts)
        detailsStack.addArrangedSubview(valueLiquid)
        
        addSubview(editingContainer)
        
        addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(editButton)
        buttonsStack.addArrangedSubview(deleteButton)
    }

    func setupConstraints() {
        
        detailsStack
            .topAnchor(in: self, padding: 60)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
        
        editingContainer
            .topAnchor(in: self, padding: 60)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
        
        buttonsStack
            .bottomAnchor(in: self, attribute: .bottom, padding: 16, layoutOption: .useSafeArea)
            .leftAnchor(in: self, padding: 16)
            .rightAnchor(in: self, padding: 16)
            .heightAnchor(45)
    }
    
    func setupConfiguration() {
        self.backgroundColor = .white
    }
}
