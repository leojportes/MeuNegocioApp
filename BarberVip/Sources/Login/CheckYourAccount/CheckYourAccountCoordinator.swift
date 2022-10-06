//
//  CheckYourAccountCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 06/10/22.
//

import Foundation

final class CheckYourAccountCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = CheckYourAccountViewModel(coordinator: self)
        let controller = CheckYourAccountController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        controller.modalPresentationStyle = .pageSheet
        configuration.navigationController?.present(controller, animated: true)
    }
    
    func closed() {
        configuration.navigationController?.dismiss(animated: true)
    }
}
