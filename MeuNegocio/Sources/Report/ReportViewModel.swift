//
//  ReportViewModel.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 26/09/22.
//

import Foundation

protocol ReportViewModelProtocol {
    func makeTotalAmount(_ procedures: [GetProcedureModel]) -> String
    func dailyProcedures(procedures: [GetProcedureModel]) -> [GetProcedureModel]
    func weeklyProceduresLast7Days(procedures: [GetProcedureModel]) -> [GetProcedureModel]
    func monthlyProceduresThisMonth(procedures: [GetProcedureModel]) -> [GetProcedureModel]
    func percentageFromString(percent: String, baseAmount: String) -> String
    func getLast7Days() -> [String]
    var returnCurrentDate: String { get set }
    var dateRangeMonthly: String { get set }
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

    var dateRangeMonthly: String = {
        let datesOfCurrentMonth = Date.getDatesOfCurrentMonth()
        return "\(PDFModel.monthlyTitle)_\(datesOfCurrentMonth.first.orEmpty)_\(datesOfCurrentMonth.last.orEmpty)"
            .replacingOccurrences(of: "/", with: "-")
    }()
    
    // MARK: - Public methods
    
    /// We set up the total value of the procedure.
    func makeTotalAmount(_ procedures: [GetProcedureModel]) -> String {
        let proceduresAmounts: [Double] = procedures.map({ Double($0.value) ?? 00.00 })
        let values = proceduresAmounts.map({ $0.plata })
        let amount = values.map { $0 }
        let sum = amount.reduce(0, +)
        return sum.rawValue.plata.string(currency: .br)
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

    /// Get procedures for this month.
    func monthlyProceduresThisMonth(procedures: [GetProcedureModel]) -> [GetProcedureModel] {
        let thisMonth = Date.getDatesOfCurrentMonth()
        let monthlyProcedures = procedures.filter({ thisMonth.contains($0.currentDate) })
        return monthlyProcedures
    }
    
    /// Calculates the percentage from a given string.
    func percentageFromString(percent: String, baseAmount: String) -> String {
         guard let amount = Double(
            baseAmount
                .replacingOccurrences(of: "R$", with: "")
                .dropFirst()
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: ".")
                .replacingOccurrences(of: " ", with: ".")
         ) else { return "" }
        
        guard let percentage = Double(percent) else { return ""}
   
        let percentageAmount = Percentage(rawValue: (percentage * amount) / 100)
            .rawValue
            .rounded(.down)
            .plata
            .string(currency: .br)

        return percentageAmount
    }
}

private extension String {
    var percentage: Percentage? {
        if let doubleValue = Double(self) {
            return Percentage(rawValue: doubleValue)
        }
        return nil
    }
}

import Foundation
///
public struct Percentage: RawRepresentable, ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Double

    public var rawValue: Double

    public var fraction: Double { rawValue / 100 }

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()

    public var fractionDigits: Int = 2 {
        didSet {
            formatter.minimumFractionDigits = fractionDigits
            formatter.maximumFractionDigits = fractionDigits
        }
    }

    public var formattedValue: String {
        let value = NSNumber(value: rawValue)
        return formatter.string(from: value) ?? ""
    }

    // MARK: - Init & Codable

    public init(integerLiteral value: Double) {
        self.init(rawValue: value)
    }

    public init(rawValue: Double) {
        self.rawValue = rawValue
    }

    public init(string stringValue: String) {
        let floatValue = (stringValue as NSString).doubleValue
        self.init(rawValue: floatValue)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(Double.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

// MARK: - CustomDebugStringConvertible

extension Percentage: CustomDebugStringConvertible {
    public var debugDescription: String { formattedValue }
}

// MARK: - Equatable, Comparable, Hashable

extension Percentage: Equatable, Comparable, Codable {
    public static func == (lhs: Percentage, rhs: Percentage) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public static func < (lhs: Percentage, rhs: Percentage) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public static func += (lhs: inout Self, rhs: Self) {
        lhs.rawValue += rhs.rawValue
    }
}
