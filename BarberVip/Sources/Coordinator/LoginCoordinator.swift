//
//  LoginCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {
    override func start() {
        let controller = LoginViewController(coordinator: self)
        controller.navigateToHome = navigateToHome
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateToHome() {
        let coordinator = HomeCoordinator(with: configuration)
        coordinator.start()
    }
}
