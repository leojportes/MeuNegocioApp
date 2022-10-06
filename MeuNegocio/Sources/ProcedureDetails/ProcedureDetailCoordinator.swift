//
//  ProcedureDetailCoordinator.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import UIKit

class ProcedureDetailCoordinator: BaseCoordinator {
    
    public var procedure: GetProcedureModel? = nil
    
    override func start() {
        guard let procedure = procedure else { return }
        let viewModel = ProcedureDetailViewModel(coordinator: self)
        let controller = ProcedureDetailViewController(viewModel: viewModel, coordinator: self, procedure: procedure)
        controller.modalPresentationStyle = .pageSheet
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.present(controller, animated: true)
    }

}
