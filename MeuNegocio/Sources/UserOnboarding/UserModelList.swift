//
//  UserModel.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 30/09/22.
//

import Foundation

// MARK: - UserModelElement
typealias UserModelList = [UserModel]

struct UserModel: Decodable {
    let id: String
    let name: String
    let barbershop: String
    let city, state, email: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, barbershop, city, state, email
        case v = "__v"
    }
}

struct CreateUserModel: Codable {
    let name: String
    let barbershop: String
    let city: String
    let state: String
    let email: String
}

