//
//  StartViewModel.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 27/10/22.
//

import Foundation
import FirebaseAuth

protocol StartViewModelProtocol {
    func validate()
}

class StartViewModel: StartViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: StartCoordinator?
    
    // MARK: - Init
    init(coordinator: StartCoordinator?) {
        self.coordinator = coordinator
    }
    
    func validate() {
        let email = MNUserDefaults.get(stringForKey: MNKeys.email) ?? ""
        let password = MNUserDefaults.get(stringForKey: MNKeys.password) ?? ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            /// Checa se existe valor na chave
            if MNUserDefaults.checkExistenceKey(key: MNKeys.email) {
                Auth.auth().signIn(withEmail: email,
                                   password:  password) { _, error in
                    if error != nil {
                        self.coordinator?.navigateToLogin()
                    } else {
                        self.coordinator?.navigateToHome()
                    }
                }
            } else {
                self.coordinator?.navigateToLogin()
            }
        }
    }
}
