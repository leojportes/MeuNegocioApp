//
//  CreateAccountViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 20/08/22.
//

import FirebaseAuth
import Foundation

protocol CreateAccountViewModelProtocol: AnyObject {
    func createAccount(_ email: String, _ password: String, _ nameBarber: String, resultCreateUser: @escaping (Bool, String) -> Void)
    func closed()
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: CreateAccountCoordinator?
    
    // MARK: - Init
    init(coordinator: CreateAccountCoordinator?) {
        self.coordinator = coordinator
    }
    
    func createAccount(_ email: String, _ password: String, _ nameBarber: String, resultCreateUser: @escaping (Bool, String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                guard let typeError = error as? NSError else { return }
                resultCreateUser(false, self.descriptionError(error: typeError))
            } else {
                resultCreateUser(true, .stringEmpty)
            }
        }
    }
    
    private func descriptionError(error: NSError) -> String {
        var description: String = .stringEmpty
        
        switch error.code {
        case AuthErrorCode.invalidEmail.rawValue:
            description = "E-mail invalido"
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            description = "Já existe uma conta com esse e-mail"
        default:
            description = "Tente novamente mais tarde"
        }
        
        return description
    }
    
    // MARK: - Routes
    func closed() {
        coordinator?.closed()
    }
    
}
