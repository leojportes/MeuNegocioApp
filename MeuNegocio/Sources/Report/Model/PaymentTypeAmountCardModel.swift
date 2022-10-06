//
//  PaymentTypeAmountCardModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 01/10/22.
//

import Foundation

struct PaymentTypeAmountCardModel {
    let debit: String
    let credit: String
    let cash: String
    let pix: String
    
    init(procedures: [GetProcedureModel], viewModel: ReportViewModelProtocol) {
        let debitAmount = viewModel.makeTotalAmount(procedures.filter({ $0.formPayment == .debit }))
        let creditAmount = viewModel.makeTotalAmount(procedures.filter({ $0.formPayment == .credit }))
        let cashAmount = viewModel.makeTotalAmount(procedures.filter({ $0.formPayment == .cash }))
        let pixAmount = viewModel.makeTotalAmount(procedures.filter({ $0.formPayment == .pix }))
        
        self.debit = debitAmount
        self.credit = creditAmount
        self.cash = cashAmount
        self.pix = pixAmount
    }
}

enum ReportType: String {
    case daily = "diário"
    case weekly = "semanal"
}

struct PDFModel {
    static let columsTitles = ["Método", "Cliente", "Data", "Valor"]
    static let title = "Relatório de procedimentos"
    static let dailyTitle = "RelatorioDiario"
    static let weeklyTitle = "RelatorioSemanal"
}
