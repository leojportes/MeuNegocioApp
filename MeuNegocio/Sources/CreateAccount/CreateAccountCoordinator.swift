//
//  CreateAccountCoordinator.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 15/08/22.
//


final class CreateAccountCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = CreateAccountViewModel(coordinator: self)
        let controller = CreateAccountViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.present(controller, animated: true)
    }
    
    func closed() {
        configuration.navigationController?.dismiss(animated: true)
    }
}
