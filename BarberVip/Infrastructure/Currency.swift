//
//  Currency.swift
//  BarberVip
//
//  Created by Leonardo Portes on 05/10/22.
//

import Foundation

/// This struct is reponsible to map and format currency values.
///
///
/// *Example:*
///
///     struct ApiResponse {
///         let amount: Currency
///     }
///
///     let response = api.getAmount()
///     response.amount.string(currency: .br)
///
public typealias Currency = CurrencyRow<CurrencyDefaultDecimals>

public struct CurrencyDefaultDecimals: CurrencyDecimals {
    public static var decimals: Int = 2

    public static func decode(container: SingleValueDecodingContainer) throws -> Int64 {
        do {
            return try container.decode(Int64.self)
        } catch let DecodingError.dataCorrupted(context) {
            throw DecodingError.typeMismatch(Int64.self, context)
        } catch {
            throw error
        }
    }
}

/// Used to create a new currency format and allow for the desired number of decimal digits
public protocol CurrencyDecimals {
    static var decimals: Int { get }
    static func decode(container: SingleValueDecodingContainer) throws -> Int64
}

/// A generic struct that represents a currency value and allows for any decimals.
public struct CurrencyRow<T>: RawRepresentable, ExpressibleByIntegerLiteral, Codable where T: CurrencyDecimals {
    public typealias IntegerLiteralType = Int64

    public var rawValue: Int64

    public var locale: Locale? = Self.defaultLocale
    public var currencySymbol: CurrencySymbol = .none

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    // MARK: - Init & Codable

    public init(integerLiteral value: Int64) {
        self.init(rawValue: value)
    }

    public init(rawValue: Int64) {
        self.rawValue = rawValue
    }

    public init(realValue: Double) {
        rawValue = Int64(realValue * pow(10.0, Double(T.decimals)))
    }

    private init(doubleValue: Double) {
        rawValue = Int64(doubleValue.rounded(.toNearestOrAwayFromZero))
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try T.decode(container: container)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    // MARK: - Public

    public static var zero: CurrencyRow<T> {
        CurrencyRow<T>(rawValue: 0)
    }

    /// Converts rawValue to Double.
    ///
    ///
    /// *Example:*
    ///
    ///     let amount = Currency(rawValue: 1230)
    ///     amount.realValue // returns 12,30
    ///
    public var realValue: Double {
        Double(rawValue) / pow(10.0, Double(T.decimals))
    }

    public var roundedValue: Double {
        (realValue * 100.0).rounded(.toNearestOrAwayFromZero) / 100.0
    }

    /// Formats rawValue using the currency symbol.
    /// - Parameter currency: currency symbol to use when formatting
    /// - Returns: formatted string
    ///
    /// *Example:*
    ///
    ///     let amount = Currency(rawValue: 1230)
    ///     amount.string(currency: .br) // returns "R$ 12,30"
    public func string(currency: CurrencySymbol) -> String {
        format(currencySymbol: currency)
    }

    /// Formats rawValue using the selected locale and returns its whole.
    ///
    ///
    /// *Example:*
    ///
    ///     let amount = Currency(rawValue: 1230)
    ///     amount.formattedValue // returns "12"
    ///
    public var whole: String {
        let array = format(currencySymbol: .none).split(separator: decimalSeparator)
        return array.isEmpty ? "00" : String(array[0])
    }

    /// Formats rawValue using the selected locale and returns its fraction.
    ///
    ///
    /// *Example:*
    ///
    ///     let amount = Currency(rawValue: 1230)
    ///     amount.formattedValue // returns "30"
    ///
    public var fraction: String {
        let array = format(currencySymbol: .none).split(separator: decimalSeparator)
        return array.count > 1 ? String(array[1]) : "00"
    }

    /// Returns inverted value.
    ///
    ///
    /// *Example:*
    ///
    ///     let amount = Currency(rawValue: -1230)
    ///     amount.inverted // returns "1230"
    ///
    ///     let amount = Currency(rawValue: 1230)
    ///     amount.inverted // returns "-1230"
    ///
    public var inverted: CurrencyRow {
        CurrencyRow(rawValue: rawValue * -1)
    }

    /// Returns absolute value.
    ///
    ///
    /// *Example:*
    ///
    ///     let amount = Currency(rawValue: -1230)
    ///     amount.absolute // returns "1230"
    ///
    ///     let amount = Currency(rawValue: 1230)
    ///     amount.absolute // returns "1230"
    ///
    public var absolute: CurrencyRow {
        CurrencyRow(rawValue: abs(rawValue))
    }

    public func convertTo<U: CurrencyDecimals>(_ type: CurrencyRow<U>.Type) -> CurrencyRow<U> {
        let value = Double(rawValue) * pow(10.0, Double(U.decimals - T.decimals))
        return CurrencyRow<U>(doubleValue: value)
    }

    // MARK: - Internal

    var decimalSeparator: Character {
        locale?.decimalSeparator?.first ?? ","
    }

    public func format(currencySymbol: CurrencySymbol) -> String {
        configureFormatter(currencySymbol: currencySymbol)
            .string(from: NSNumber(value: roundedValue))?
            .filter { currencySymbol != .none || $0 != "\u{A0}" }
            ?? "-"
    }

    func configureFormatter(currencySymbol: CurrencySymbol) -> NumberFormatter {
        formatter.locale = locale ?? Self.defaultLocale
        formatter.currencySymbol = currencySymbol != .none ? "\(currencySymbol.rawValue)" : ""
        return formatter
    }

}

// MARK: - Static

public extension CurrencyRow {
    enum CurrencySymbol: String {
        case none = ""
        case br = "R$"
        case brl = "BRL"
        case usd = "USD"
    }

    static var defaultLocale: Locale {
        Locale(identifier: "pt_BR")
    }
    static var defaultCurrencySymbol: CurrencySymbol {
        CurrencySymbol.none
    }
}

// MARK: - Equatable, Comparable, Codable

extension CurrencyRow: Equatable, Comparable {
    public static func == (lhs: Self, rhs: CurrencyRow) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    public static func != (lhs: Self, rhs: CurrencyRow) -> Bool {
        lhs.rawValue != rhs.rawValue
    }

    public static func < (lhs: CurrencyRow, rhs: CurrencyRow) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public static func > (lhs: CurrencyRow, rhs: CurrencyRow) -> Bool {
        lhs.rawValue > rhs.rawValue
    }

    public static func <= (lhs: CurrencyRow, rhs: CurrencyRow) -> Bool {
        lhs.rawValue <= rhs.rawValue
    }

    public static func >= (lhs: CurrencyRow, rhs: CurrencyRow) -> Bool {
        lhs.rawValue >= rhs.rawValue
    }

    public static func == <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Bool {
        lhs == rhs.convertTo(Self.self)
    }

    public static func != <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Bool {
        lhs != rhs.convertTo(Self.self)
    }

    public static func < <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Bool {
        lhs < rhs.convertTo(Self.self)
    }

    public static func > <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Bool {
        lhs > rhs.convertTo(Self.self)
    }

    public static func <= <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Bool {
        lhs <= rhs.convertTo(Self.self)
    }

    public static func >= <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Bool {
        lhs >= rhs.convertTo(Self.self)
    }
}

public extension CurrencyRow {
    static prefix func - (value: Self) -> Self {
        value.inverted
    }

    static func + (lhs: CurrencyRow, rhs: CurrencyRow) -> CurrencyRow {
        CurrencyRow(rawValue: lhs.rawValue + rhs.rawValue)
    }

    static func - (lhs: CurrencyRow, rhs: CurrencyRow) -> CurrencyRow {
        CurrencyRow(rawValue: lhs.rawValue - rhs.rawValue)
    }

    static func / (lhs: CurrencyRow, rhs: Int) -> CurrencyRow {
        CurrencyRow(rawValue: lhs.rawValue / Int64(rhs))
    }

    static func * (lhs: CurrencyRow, rhs: Int) -> CurrencyRow {
        CurrencyRow(rawValue: lhs.rawValue * Int64(rhs))
    }

    static func / (lhs: CurrencyRow, rhs: Double) -> CurrencyRow {
        CurrencyRow(realValue: Double(lhs.realValue) / rhs)
    }

    static func * (lhs: CurrencyRow, rhs: Double) -> CurrencyRow {
        CurrencyRow(realValue: Double(lhs.realValue) * rhs)
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs.rawValue += rhs.rawValue
    }

    static func + <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Self {
        lhs + rhs.convertTo(Self.self)
    }

    static func - <U: CurrencyDecimals>(lhs: Self, rhs: CurrencyRow<U>) -> Self {
        lhs - rhs.convertTo(Self.self)
    }

    static func += <U: CurrencyDecimals>(lhs: inout Self, rhs: CurrencyRow<U>) {
        lhs += rhs.convertTo(Self.self)
    }
}

// MARK: - Hashable

extension CurrencyRow: Hashable {}

// MARK: - Int64

public extension Int64 {
    var plata: Currency { .init(rawValue: self) }
}

public extension Double {
    var plata: Currency {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        let stringValue = formatter.string(from: NSNumber(value: self)).orEmpty
        let intValue = Int64(stringValue.decimalsOnly) ?? 0

        return .init(rawValue: intValue)
    }
}

public extension Optional where Wrapped == Currency {
    var orZero: Currency {
        self ?? .zero
    }
}
