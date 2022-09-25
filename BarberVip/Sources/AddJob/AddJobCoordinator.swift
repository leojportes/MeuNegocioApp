//
//  AddJobCoordinator.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import Foundation

class AddJobCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = AddJobViewModel(coordinator: self)
        let controller = AddJobViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = String.stringEmpty
        configuration.navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        configuration.navigationController?.pushViewController(controller, animated: true)    }
    
    func closed() {
        configuration.navigationController?.dismiss(animated: true, completion: nil)
    }
}


