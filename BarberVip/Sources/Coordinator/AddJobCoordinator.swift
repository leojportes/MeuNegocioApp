//
//  AddJobCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import Foundation

class AddJobCoordinator: BaseCoordinator {
    override func start() {
        let controller = AddJobViewController(coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.present(controller, animated: true)
    }
}


