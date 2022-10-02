//
//  ForgetPasswordViewModel.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import Foundation
import FirebaseAuth

protocol ForgetPasswordViewModelProtocol {
    func resetPassFirebase(email: String, completion: @escaping (Bool, String) -> Void)
}

class ForgetPasswordViewModel: ForgetPasswordViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: ForgetPasswordCoordinator?
    
    // MARK: - Init
    init(coordinator: ForgetPasswordCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: - Routes
    func resetPassFirebase(email: String, completion: @escaping (Bool, String) -> Void) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: email) { error in
            if error != nil {
                guard let typeError = error as? NSError else { return }
                completion(false, self.descriptionError(error: typeError))
                return
            }
            completion(true, .stringEmpty)
        }
    }
    
    private func descriptionError(error: NSError) -> String {
        var description: String = .stringEmpty
        
        switch error.code {
        case AuthErrorCode.userNotFound.rawValue:
            description = "Não existe uma conta com esse email"
        case AuthErrorCode.invalidEmail.rawValue:
            description = "E-mail invalido"
        default:
            description = "Ocorreu um erro, tente novamente mais tarde"
        }
        
        return description
    }

}
