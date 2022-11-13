//
//  StartCoordinator.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 27/10/22.
//

import Foundation

class StartCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = StartViewModel(coordinator: self)
        let controller = StartViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    func navigateToLogin() {
        let coordinator = LoginCoordinator(with: configuration)
        coordinator.start()
        configuration.navigationController?.removeViewController(StartViewController.self)
    }
    
    func navigateToHome() {
        let coordinator = HomeCoordinator(with: configuration)
        coordinator.start()
        configuration.navigationController?.removeViewController(StartViewController.self)
    }
}
