//
//  PaymentMethodType.swift
//  BarberVip
//
//  Created by Leonardo Portes on 24/09/22.
//

import Foundation

enum PaymentMethodType: String, Decodable {
    case pix = "Pix"
    case cash = "Dinheiro"
    case credit = "Crédito"
    case debit = "Débito"
    case other = "Outro"
}
