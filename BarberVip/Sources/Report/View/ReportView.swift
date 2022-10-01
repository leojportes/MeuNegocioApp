//
//  ReportView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import UIKit

final class ReportView: UIView {
    
    // MARK: - Action properties
    var didApplyDiscount: (Bool) -> Void?
    var didTapDownloadDailyHistoric: Action?
    var didTapDownloadWeeklyHistoric: Action?
    var didEditingTextField: (UITextField) -> Void? = { _ in nil }
    
    // MARK: - Init
    init(
        didTapDiscountSwitch: @escaping (Bool) -> Void?,
        didTapDownloadDailyHistoric: @escaping Action,
        didTapDownloadWeeklyHistoric: @escaping Action
    ) {
        self.didApplyDiscount = didTapDiscountSwitch
        self.didTapDownloadDailyHistoric = didTapDownloadDailyHistoric
        self.didTapDownloadWeeklyHistoric = didTapDownloadWeeklyHistoric
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.BarberColors.lightGray
        return view
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// Apply discount
    private lazy var applydiscountCardView = CardView()
    private lazy var applydiscountTitleLabel = BarberLabel(
        text: "Aplicar porcentagem:",
        font: UIFont.boldSystemFont(ofSize: 16)
    )
    
    private lazy var applyDiscountStatusView = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.roundCorners(cornerRadius: 5)
        $0.backgroundColor = .BarberColors.grayDescription
    }
    
    private lazy var discountPercentageTextField = CustomTextField(showBaseLine: true) .. {
        $0.textAlignment = .center
        $0.keyboardType = .decimalPad
        $0.placeholder = "Ex: 10%"
        $0.delegate = self
        $0.addTarget(self, action: #selector(didInputTextfield), for: .editingChanged)
    }
    
    @objc
    func didInputTextfield(sender: UITextField) {
        self.didEditingTextField(sender)
    }

    /// Historic cards
    private lazy var dailyHistoricCard = ReportCardView(
        didTapReportDownload: weakify { $0.didTapDownloadDailyHistoric?() }
    ) .. { $0.loadingIndicatorView(show: true) }

    private lazy var weeklyHistoricCard = ReportCardView(
        didTapReportDownload: weakify { $0.didTapDownloadWeeklyHistoric?() }
    ) .. { $0.loadingIndicatorView(show: true) }
    
    private lazy var paymentTypeAmountTitle = BarberLabel(
        text: "Métodos de pagamento",
        font: UIFont.boldSystemFont(ofSize: 16)
    )
    
    /// Payment methods amount
    private lazy var paymentTypeAmountCard = PaymentTypeAmountCardView() .. { $0.loadingIndicatorView(show: true) }
    
    // MARK: - Bind methods
    func setupDailyCard(_ totalAmountValue: String, _ totalProceduresValue: String) {
        dailyHistoricCard.setup(
            title: "Histórico diário",
            totalAmountTitle: "Total • hoje",
            totalAmountValue: "R$\(totalAmountValue)",
            totalProceduresValue: totalProceduresValue,
            reportDownloadTitle: "Baixar relatório diário"
        )
        dailyHistoricCard.loadingIndicatorView(show: false)
    }

    func setupWeeklyCard(_ totalAmountValue: String, _ totalProceduresValue: String) {
        weeklyHistoricCard.setup(
            title: "Histórico semanal",
            totalAmountTitle: "Total • últimos 7 dias",
            totalAmountValue: "R$\(totalAmountValue)",
            totalProceduresValue: totalProceduresValue,
            reportDownloadTitle: "Baixar relatório semanal"
        )
        weeklyHistoricCard.loadingIndicatorView(show: false)
    }

    func setupPaymentTypeAmountCard(
        _ debitAmount: String = "R$00,00",
        _ creditAmount: String = "R$00,00",
        _ cashAmount: String = "R$00,00",
        _ pixAmount: String = "R$00,00"
    ) {
        paymentTypeAmountCard.setup(
            debitAmount: debitAmount,
            creditAmount: creditAmount,
            cashAmount: cashAmount,
            pixAmount: pixAmount
        )
        paymentTypeAmountCard.loadingIndicatorView(show: false)
    }
    
}

// MARK: - View code contract
extension ReportView: ViewCodeContract {
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(dailyHistoricCard)
        containerView.addSubview(weeklyHistoricCard)
        containerView.addSubview(applydiscountCardView)
        applydiscountCardView.addSubview(applydiscountTitleLabel)
        applydiscountCardView.addSubview(applyDiscountStatusView)
        applydiscountCardView.addSubview(discountPercentageTextField)
        
        containerView.addSubview(paymentTypeAmountTitle)
        containerView.addSubview(paymentTypeAmountCard)
    }
    
    func setupConstraints() {
        
        scrollView
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useSafeArea)
        
        containerView
            .pin(toEdgesOf: scrollView)
        containerView
            .widthAnchor(in: scrollView, 1)
            .heightAnchor(in: scrollView, 1, withLayoutPriorityValue: 250)

        /// Apply discount constraints
        applydiscountCardView
            .topAnchor(in: containerView, padding: 30)
            .leftAnchor(in: containerView, padding: 15)
            .rightAnchor(in: containerView, padding: 15)
            .heightAnchor(50)

        applydiscountTitleLabel
            .centerY(in: applydiscountCardView)
            .heightAnchor(20)
            .leftAnchor(in: applydiscountCardView, padding: 15)
        
        applyDiscountStatusView
            .centerY(in: applydiscountCardView)
            .rightAnchor(in: applydiscountCardView, padding: 15)
            .heightAnchor(10)
            .widthAnchor(10)
        
        discountPercentageTextField
            .centerY(in: applydiscountCardView)
            .leftAnchor(in: applydiscountTitleLabel, attribute: .right, padding: 10)
            .heightAnchor(20)
            .widthAnchor(65)
        
        /// Historic cards constraints
        dailyHistoricCard
            .topAnchor(in: applydiscountCardView, attribute: .bottom, padding: 20)
            .leftAnchor(in: containerView, padding: 15)
            .rightAnchor(in: containerView, padding: 15)
            .heightAnchor(145)
        
        weeklyHistoricCard
            .topAnchor(in: dailyHistoricCard, attribute: .bottom, padding: 20)
            .leftAnchor(in: containerView, padding: 15)
            .rightAnchor(in: containerView, padding: 15)
            .heightAnchor(145)
        
        paymentTypeAmountTitle
            .topAnchor(in: weeklyHistoricCard, attribute: .bottom, padding: 20)
            .leftAnchor(in: containerView, padding: 18)
            .heightAnchor(20)
        
        paymentTypeAmountCard
            .topAnchor(in: paymentTypeAmountTitle, attribute: .bottom, padding: 6)
            .leftAnchor(in: containerView, padding: 15)
            .rightAnchor(in: containerView, padding: 15)
            .heightAnchor(170)
            .bottomAnchor(in: containerView, padding: 30)

    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.lightGray
    }

}

extension ReportView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string) as String
        if let num = Double(newText), num >= -1 && num <= 100 { return true } else { return false }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didApplyDiscount(textField.hasText)
        applyDiscountStatusView.backgroundColor = textField.hasText ? .BarberColors.greenMedium : .BarberColors.grayDescription
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
