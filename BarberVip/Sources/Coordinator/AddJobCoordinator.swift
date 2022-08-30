//
//  AddJobCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import Foundation

class AddJobCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = AddJobViewModel()
        let controller = AddJobViewController(viewModel: viewModel, coordinator: self)
        controller.closedView = closedView
        configuration.viewController = controller
        configuration.navigationController?.present(controller, animated: true)
    }
    
    private func closedView() {
        configuration.navigationController?.dismiss(animated: true, completion: nil)
    }
}


