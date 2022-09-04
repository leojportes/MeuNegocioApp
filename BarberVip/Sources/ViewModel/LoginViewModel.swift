//
//  LoginViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 18/08/22.
//

import FirebaseAuth
import FirebaseCore

protocol LoginViewModelProtocol: AnyObject {
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool, String) -> Void)
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
    
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                guard let typeError = error as? NSError else { return }
                resultLogin(false, self.descriptionError(error: typeError))
            } else {
                resultLogin(true, .stringEmpty)
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
    
    private func descriptionError(error: NSError) -> String {
        var description: String = .stringEmpty
        
        switch error.code {
        case AuthErrorCode.invalidEmail.rawValue:
            description = "verifique o e-mail informado e tente novamente"
        case AuthErrorCode.wrongPassword.rawValue:
            description = "senha incorreta"
        default:
            description = "Ocorreu um erro, tente novamente mais tarde"
        }
        
        return description
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
