//
//  ProfileCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit

class ProfileCoordinator: BaseCoordinator {
    override func start() {
        let controller = ProfileViewController(coordinator: self)
        configuration.viewController = controller
        controller.closed = closed
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
