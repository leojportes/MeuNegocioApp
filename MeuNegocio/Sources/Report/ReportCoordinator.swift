//
//  ReportCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation

final class ReportCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = ReportViewModel()
        let controller = ReportViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
}
