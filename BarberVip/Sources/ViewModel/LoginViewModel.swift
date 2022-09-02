//
//  LoginViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 18/08/22.
//

import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool) -> Void)
    func authLoginGoogle(credentials: AuthCredential, resultAuth: @escaping (Bool) -> Void)
    func navigateToHome()
    func navigateToForgotPassword()
    func navigateToRegister()
}

class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: LoginCoordinator?
    
    // MARK: - Init
    init(coordinator: LoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                resultLogin(false)
            } else {
                resultLogin(true)
            }
        }
    }
    
    func authLoginGoogle(credentials: AuthCredential, resultAuth: @escaping (Bool) -> Void) {
        Auth.auth().signIn(with: credentials) { (result, error) in
            if error != nil {
                resultAuth(false)
            }else {
                resultAuth(true)
            }
        }
    }
    
    // MARK: - Routes
    func navigateToHome() {
        coordinator?.navigateToHome()
    }
    
    func navigateToForgotPassword() {
        coordinator?.navigateToForgotPassword()
    }
    
    func navigateToRegister() {
        coordinator?.navigateToRegister()
    }
    
}
