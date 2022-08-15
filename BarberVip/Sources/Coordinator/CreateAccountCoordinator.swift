//
//  CreateAccountCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 15/08/22.
//


final class CreateAccountCoordinator: BaseCoordinator {
    override func start() {
        let controller = CreateAccountViewController(coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = false
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = "voltar"
        configuration.navigationController?.navigationBar.tintColor = .BarberColors.lightBrown
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
