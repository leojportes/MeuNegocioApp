//
//  ReportCoordinator.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation

final class ReportCoordinator: BaseCoordinator {
    func start(procedures: [GetProcedureModel]) {
        let viewModel = ReportViewModel()
        let controller = ReportViewController(viewModel: viewModel, coordinator: self, procedures: procedures)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
}
