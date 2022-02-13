//
//  HomeCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import Foundation

final class HomeCoordinator: BaseCoordinator {
    override func start() {
        let controller = HomeViewController(coordinator: self)
        controller.didTapNextFlow = navigateNextFlow
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateNextFlow() {
        print("navigate next flow tapped")
    }
}
