//
//  CreateAccountViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 20/08/22.
//

import FirebaseAuth

protocol CreateAccountViewModelProtocol: AnyObject {
    func createAccount(_ email: String, _ password: String, _ nameBarber: String, resultCreateUser: @escaping (Bool) -> Void)
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    func createAccount(_ email: String, _ password: String, _ nameBarber: String, resultCreateUser: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                resultCreateUser(false)
            }else {
                resultCreateUser(true)
            }
        }
    }
    
}
