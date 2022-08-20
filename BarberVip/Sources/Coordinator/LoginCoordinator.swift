//
//  LoginCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {
    override func start() {
        let teste = LoginViewModel()
        let controller = LoginViewController(viewModel: teste, coordinator: self)
        controller.navigateToHome = navigateToHome
        controller.navigateToForgotPassword = navigateToForgotPassword
        controller.navigateToCreateAccount = navigateToCreateAccount
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateToHome() {
        let coordinator = HomeCoordinator(with: configuration)
        coordinator.start()
    }
    
    private func navigateToForgotPassword() {
        print("deu certo o password")
    }
    
    private func navigateToCreateAccount() {
        let coordinator = CreateAccountCoordinator(with: configuration)
        coordinator.start()
    }
}
