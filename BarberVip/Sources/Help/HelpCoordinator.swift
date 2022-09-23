//
//  HelpCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import UIKit

class HelpCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = HelpViewModel(coordinator: self)
        let controller = HelpViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    func closed() {
        let coordinator = LoginCoordinator(with: configuration)
        configuration.navigationController?.viewControllers.removeAll()
        coordinator.start()
    }
}
