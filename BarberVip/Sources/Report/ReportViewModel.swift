//
//  ReportViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/09/22.
//

import Foundation

protocol ReportViewModelProtocol {
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void)
    func makeTotalAmount(_ procedures: [GetProcedureModel]) -> String
    func dailyProcedures(procedures: [GetProcedureModel]) -> [GetProcedureModel]
    func weeklyProceduresLast7Days(procedures: [GetProcedureModel]) -> [GetProcedureModel]
    func calcPercentageFromString(percent: String, baseAmount: String) -> String
    func getLast7Days() -> [String]
    var returnCurrentDate: String { get set }
}

class ReportViewModel: ReportViewModelProtocol {

    // MARK: - Properties
    let service = HomeService()
    
    /// Return current data (today).
    var returnCurrentDate: String = {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
        return dateString
    }()
    
    // MARK: - Fetch methods
    /// Get all procedures list.
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void) {
        service.getProcedureList { result in
            completion(result)
        }
    }
    
    // MARK: - Public methods
    
    /// We set up the total value of the procedure.
    func makeTotalAmount(_ procedures: [GetProcedureModel]) -> String {
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
    
    /// Get last seven days in array of string.
    func getLast7Days() -> [String] {
        return Date.getDates(forLastNDays: 7)
    }
    
    /// Get procedures for today.
    func dailyProcedures(procedures: [GetProcedureModel]) -> [GetProcedureModel] {
        let today = returnCurrentDate
        /// Aqui filtramos os procedimentos do dia atual.
        let dailyProcedures = procedures.filter({$0.currentDate == today})
        return dailyProcedures
    }
    
    /// Get procedures for the last 7 days.
    func weeklyProceduresLast7Days(procedures: [GetProcedureModel]) -> [GetProcedureModel] {
        let last7Days = self.getLast7Days()
        let weeklyProcedures = procedures.filter({ last7Days.contains($0.currentDate) })
        return weeklyProcedures
    }
    
    /// Calculates the percentage from a given string.
    func calcPercentageFromString(percent: String, baseAmount: String) -> String {
        guard let porcent = Double(percent) else { return ""}
        guard let amount = Double(baseAmount.replacingOccurrences(of: ",", with: ".")) else { return ""}
        let calc = (porcent * amount) / 100
        let result = String(format: "%.2f", calc).replacingOccurrences(of: ".", with: ",")
        return result
    }
}
