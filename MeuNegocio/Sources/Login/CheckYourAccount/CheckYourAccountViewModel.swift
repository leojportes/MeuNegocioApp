//
//  CheckYourAccountViewModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 06/10/22.
//

import Foundation

protocol CheckYourAccountViewModelProtocol {
    func sendVerifiedEmail()
}

class CheckYourAccountViewModel: CheckYourAccountViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: CheckYourAccountCoordinator?
    
    // MARK: - Init
    init(coordinator: CheckYourAccountCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: - Routes

    func sendVerifiedEmail() {
       
    }
}
