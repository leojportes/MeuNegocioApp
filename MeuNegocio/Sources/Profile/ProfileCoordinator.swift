//
//  ProfileCoordinator.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit

class ProfileCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = ProfileViewModel(coordinator: self)
        let controller = ProfileViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        configuration.navigationController?.present(controller, animated: true)
    }
    
    func closed() {
        let coordinator = LoginCoordinator(with: configuration)
        configuration.navigationController?.dismiss(animated: true)
        configuration.navigationController?.viewControllers.removeAll()
        coordinator.start()
    }
    
    func closedView() {
        configuration.navigationController?.dismiss(animated: true)
    }
}
