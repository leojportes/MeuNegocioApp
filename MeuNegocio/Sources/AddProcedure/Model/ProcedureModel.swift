//
//  ProcedureModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 24/09/22.
//

import Foundation

public struct GetProcedureModel: Decodable {
    let _id: String
    let nameClient: String
    let typeProcedure: String
    let formPayment: PaymentMethodType
    let value: String
    let currentDate: String
    let email: String
    let costs: String?
    let valueLiquid: String?
}

public struct CreateProcedureModel: Codable {
    let nameClient: String
    let typeProcedure: String
    let formPayment: String
    let value: String
    let currentDate: String
    let email: String
    let costs: String
}

public struct ProceduresToUpdateModel: Codable {
    let nameClient: String
    let typeProcedure: String
    let formPayment: String
    let value: String
    let costs: String
}

public struct UpdatedProceduresModel: Codable {
    var nameClient: String?
    var typeProcedure: String?
    var formPayment: String?
    var value: String?
    var costs: String?
    var valueLiquid: String?
    
    init(nameClient: String = .stringEmpty,
         typeProcedure: String = .stringEmpty ,
         formPayment: String = .stringEmpty,
         value: String = .stringEmpty,
         costs: String = .stringEmpty,
         valueLiquid: String = .stringEmpty) {
        self.nameClient = nameClient
        self.typeProcedure = typeProcedure
        self.formPayment = formPayment
        self.value = value
        self.costs = costs
        self.valueLiquid = valueLiquid
    }
}
