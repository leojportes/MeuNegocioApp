//
//  ReportViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation
import UIKit
import PDFKit

final class ReportViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var procedures: [GetProcedureModel] = []
    var amountDiscount: String = "Sem porcentagem aplicada."
    var pdftable: ConfigurableTable? = nil
    
    // MARK: - Private properties
    private let viewModel: ReportViewModelProtocol
    private lazy var customView = ReportView()
    
    // MARK: - Init
    init(viewModel: ReportViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProcedures()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }

    // MARK: - Bind methods
    /// Fetch all procedures.
    private func fetchProcedures() {
        self.viewModel.getProcedureList { [weak self] result in
            DispatchQueue.main.async {
                self?.procedures = result
                self?.setupReportView(result)
            }
        }
    }

    /// Setup for report view.
    private func setupReportView(_ response: [GetProcedureModel]) {

        /// Default Values without porcentage interaction.
        self.setupWeeklyAmount(procedures: response)
        self.setupPaymentTypeAmount(procedures: response)
        self.setupDailyAmount(procedures: response)
        self.shareReportPDF(procedures: response)
        
        /// Values with porcentage interaction in textfield.
        self.customView.didEditingTextField = weakify { weakSelf, txt in
            weakSelf.customView.didApplyDiscount = weakSelf.weakify { weakSelf, hasDiscount in
                guard let percent = txt.text else { return }
                
                weakSelf.shareReportPDF(procedures: response, hasDiscount, percent: percent)
                weakSelf.setupDailyAmount(procedures: response, hasDiscount, percent: percent)
                weakSelf.setupWeeklyAmount(procedures: response, hasDiscount, percent: percent)
                weakSelf.setupPaymentTypeAmount(procedures: response, hasDiscount, percent: percent)
            }
        }
    }

    /// Configure amout for daily card.
    private func setupDailyAmount(procedures: [GetProcedureModel], _ hasDiscount: Bool = false, percent: String = "") {
        let today = viewModel.returnCurrentDate
        /// Here we filter the current day's procedures.
        let dailyProcedures = procedures.filter({$0.currentDate == today})
        /// Here we sum all the receipts of the current day.
        let makeTotalDailyAmount = viewModel.makeTotalAmount(dailyProcedures)

        if hasDiscount {
            let percentResult = viewModel.calcPercentageFromString(percent: percent, baseAmount: makeTotalDailyAmount)
            self.customView.setupDailyCard(percentResult, "\(dailyProcedures.count)")
            self.customView.setupDailyTitleIfHasDiscount("\(percent)% do total • hoje")
        } else {
            self.customView.setupDailyCard(makeTotalDailyAmount, "\(dailyProcedures.count)")
            self.customView.setupDailyTitleIfHasDiscount("Total • hoje")
        }
    }

    /// Configure amout for weekly card.
    private func setupWeeklyAmount(procedures: [GetProcedureModel], _ hasDiscount: Bool = false, percent: String = "") {
        /// Here we filter the procedures from the last 7 days.
        let weeklyProcedures = viewModel.weeklyProceduresLast7Days(procedures: procedures)
        /// Here we add the values ​​of the procedures of the last 7 days.
        let makeTotalWeeklyAmount = viewModel.makeTotalAmount(weeklyProcedures)
       
        if hasDiscount {
            let percentResult = viewModel.calcPercentageFromString(percent: percent, baseAmount: makeTotalWeeklyAmount)
            self.customView.setupWeeklyCard(percentResult, "\(weeklyProcedures.count)")
            self.customView.setupWeeklyTitleIfHasDiscount("\(percent)% do total • últimos 7 dias")
        } else {
            self.customView.setupWeeklyCard(makeTotalWeeklyAmount, "\(weeklyProcedures.count)")
            self.customView.setupWeeklyTitleIfHasDiscount("Total • últimos 7 dias")
        }
    }

    /// Configure amouts to payment type card.
    private func setupPaymentTypeAmount(procedures: [GetProcedureModel], _ hasDiscount: Bool = false, percent: String = "") {
       let items = PaymentTypeAmountCardModel(procedures: procedures, viewModel: viewModel)
        if hasDiscount {
            let debitAmount = viewModel.calcPercentageFromString(percent: percent, baseAmount: items.debit)
            let creditAmount = viewModel.calcPercentageFromString(percent: percent, baseAmount: items.credit)
            let cashAmount = viewModel.calcPercentageFromString(percent: percent, baseAmount: items.cash)
            let pixAmount = viewModel.calcPercentageFromString(percent: percent, baseAmount: items.pix)
            self.customView.setupPaymentTypeAmountCard(debitAmount, creditAmount, cashAmount, pixAmount)
        } else {
            self.customView.setupPaymentTypeAmountCard(items.debit, items.credit, items.cash, items.pix)
        }
    }

    /// Share report pdf document.
    private func shareReportPDF(procedures: [GetProcedureModel], _ hasDiscount: Bool = false, percent: String = "") {
        /// Share daily report.
        let dailyProcedures = self.viewModel.dailyProcedures(procedures: procedures)
        let totalDailyAmount = viewModel.makeTotalAmount(procedures.filter({$0.currentDate == viewModel.returnCurrentDate}))
        let totalPercentDaily = viewModel.calcPercentageFromString(percent: percent, baseAmount: totalDailyAmount)
        self.customView.didTapDownloadDailyHistoric = {
            self.sharePDF(dailyProcedures, PDFModel.dailyTitle, .daily, totalPercentDaily, hasDiscount, percent)
        }
        
        /// Share  weekly report.
        let weeklyProcedures = self.viewModel.weeklyProceduresLast7Days(procedures: procedures)
        let totalWeeklyAmount = viewModel.makeTotalAmount(weeklyProcedures)
        let totalPercentWeeklyAmount = viewModel.calcPercentageFromString(percent: percent, baseAmount: totalWeeklyAmount)
        self.customView.didTapDownloadWeeklyHistoric = {
            self.sharePDF(weeklyProcedures, PDFModel.weeklyTitle, .weekly, totalPercentWeeklyAmount, hasDiscount, percent)
        }
    }
    
    // MARK: - Aux methods
    private func setupNavigationBar() {
        title = "Relatórios"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        navigationController?.navigationBar.barTintColor = .white
    }

    /// Creates the pdf based on the registered procedures and opens the sharer.
    private func createAndSharePDF(titleFilePDF: String) {
        pdftable = ConfigurableTable()
        pdftable?.dataSource = self
        PDFBuilder.shared.createPDF()
        PDFBuilder.shared.savePdf(titleFile: titleFilePDF)
    }

    /// Check if you have any reports registered.
    private func sharePDF(
        _ procedure: [GetProcedureModel],
        _ titlePDF: String,
        _ type: ReportType,
        _ totalAmount: String = "",
        _ hasDiscount: Bool = false, _ percent: String = ""
    ) {
        if procedure.isEmpty {
            self.showAlert(title: "Ops!", messsage: "Nenhum procedimento \(type.rawValue) cadastrado para gerar relatório")
        } else {
            if hasDiscount {
                self.amountDiscount = "Total com porcentagem de \(percent)% do período \(type.rawValue): R$\(totalAmount)"
            } else {
                self.amountDiscount = "Sem porcentagem aplicada."
            }
            self.procedures = procedure
            self.createAndSharePDF(titleFilePDF: titlePDF)
        }
    }
}
