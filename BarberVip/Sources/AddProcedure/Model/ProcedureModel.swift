//
//  ProcedureModel.swift
//  BarberVip
//
//  Created by Leonardo Portes on 24/09/22.
//

import Foundation

struct GetProcedureModel: Decodable {
    let _id: String
    let nameClient: String
    let typeProcedure: String
    let formPayment: PaymentMethodType
    let value: String
    let currentDate: String
}

struct CreateProcedureModel: Codable {
    let nameClient: String
    let typeProcedure: String
    let formPayment: String
    let value: String
//    let currentDate: String - WIP
}
