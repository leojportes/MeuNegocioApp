//
//  AddProcedureCoordinator.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 26/08/22.
//

import Foundation

class AddProcedureCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = AddProcedureViewModel(coordinator: self)
        let controller = AddProcedureViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = String.stringEmpty
        configuration.navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        configuration.navigationController?.present(controller, animated: true)
    }
    
    func closed() {
        configuration.navigationController?.dismiss(animated: true, completion: nil)
    }
}


