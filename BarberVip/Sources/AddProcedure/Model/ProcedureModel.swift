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
    let email: String
//
//    init(
//        _id: String,
//        nameClient: String,
//        typeProcedure: String,
//        formPayment: PaymentMethodType,
//        value: String,
//        currentDate: String,
//        email: String,
//        hasDiscount: Bool = false,
//        percent: String = ""
//    ) {
//        self._id = _id
//        self.nameClient = nameClient
//        self.typeProcedure = typeProcedure
//        self.formPayment = formPayment
//        self.currentDate = currentDate
//        self.email = email
//
//        if hasDiscount {
//            self.value = GetProcedureModel.applyDiscount(percent: percent, value: value)
//        } else {
//            self.value = value
//        }
//    }

}

struct CreateProcedureModel: Codable {
    let nameClient: String
    let typeProcedure: String
    let formPayment: String
    let value: String
    let currentDate: String
    let email: String
}
