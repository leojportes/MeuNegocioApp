//
//  LoginViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 18/08/22.
//
import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                resultLogin(false)
            }else {
                resultLogin(true)
            }
        }
    }
    
}
