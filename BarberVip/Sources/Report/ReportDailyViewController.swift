//
//  ReportViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation
import UIKit

final class ReportViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var popAction: Action?
    
    // MARK: - Private properties
    private lazy var customView = ReportView(
        didTapDiscountSwitch: { _ in },
        didTapDownloadDailyHistoric: weakify { print($0.getLast7Days()) },
        didTapDownloadWeeklyHistoric: { print("didTapDownloadWeeklyHistoric") }
    )
    private let viewModel: ReportViewModelProtocol
    
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
        fetchCurrentProcedure()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    func getLast7Days() -> [String] {
        return Date.getDates(forLastNDays: 7)
    }
    
    private func fetchCurrentProcedure() {
        self.viewModel.getProcedureList { [weak self] result in
            DispatchQueue.main.async {
                
                self?.setupWeeklyAmount(procedures: result)
                self?.setupPaymentTypeAmount(procedures: result)
                self?.setupDailyAmount(procedures: result, isOnSwitch: false, porcent: "0")
                
                self?.customView.didChangeTF = { [weak self] txt in                    
                    self?.customView.didTapDiscountSwitch = { [weak self] sender in
                        self?.setupDailyAmount(procedures: result, isOnSwitch: sender.isOn, porcent: txt.text ?? "")
                    }
                }
                    
               
            }
        }
    }

    // MARK: - Bind methods
    private func setupDailyAmount(procedures: [GetProcedureModel], isOnSwitch: Bool, porcent: String) {
     
        if isOnSwitch {
            print(porcent)
            self.customView.setupDailyCard("444", "\(444)")
            
        } else {
            /// Aqui filtramos os procedimentos do dia atual.
            let dailyProcedures = procedures.filter({$0.currentDate == "26/09/2022"})
            /// Aqui somamos todos os recebimentos do dia atual.
            let makeTotalDailyAmount = self.makeTotalAmount(procedures: dailyProcedures)
            
            self.customView.setupDailyCard(makeTotalDailyAmount, "\(dailyProcedures.count)")
        }

    }

    private func setupWeeklyAmount(procedures: [GetProcedureModel]) {
        /// Aqui filtramos os procedimentos dos últimos 7 dias.
        let last7Days = self.getLast7Days()
        let weeklyProcedures = procedures.filter({ last7Days.contains($0.currentDate) }) //totalWeeklyProceduresValue
        
        /// Aqui somamos os valores dos procedimentos dos últimos 7 dias.
        let makeTotalWeeklyAmount = self.makeTotalAmount(procedures: weeklyProcedures)
        self.customView.setupWeeklyCard(makeTotalWeeklyAmount, "\(weeklyProcedures.count)")
    }

    private func setupPaymentTypeAmount(procedures: [GetProcedureModel]) {
        
        let debitAmount = self.makeTotalAmount(procedures: procedures.filter({ $0.formPayment == .debit }))
        let creditAmount = self.makeTotalAmount(procedures: procedures.filter({ $0.formPayment == .credit }))
        let cashAmount = self.makeTotalAmount(procedures: procedures.filter({ $0.formPayment == .cash }))
        let pixAmount = self.makeTotalAmount(procedures: procedures.filter({ $0.formPayment == .pix }))
        
        self.customView.setupPaymentTypeAmountCard(debitAmount, creditAmount, cashAmount, pixAmount)
        
    }
    
    // MARK: - Aux methods
    private func makeTotalAmount(procedures: [GetProcedureModel]) -> String {
        let values = procedures.map({
            $0.value
                .replacingOccurrences(of: ",", with: ".")
                .replacingOccurrences(of: " ", with: "")
        })
        
        let sum = values.compactMap(Double.init).reduce(0, +)
        let format = String(format: "%.2f", sum)
        
        let totalAmount = format.replacingOccurrences(of: ".", with: ",")
        return "\(totalAmount)"
    }
    
    private func returnCurrentDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
        return dateString
    }

    private func setupNavigationBar() {
        title = "Relatórios"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        navigationController?.navigationBar.barTintColor = .white
    }
}
