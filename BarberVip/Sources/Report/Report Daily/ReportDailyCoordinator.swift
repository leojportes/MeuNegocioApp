//
//  ReportDailyCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation

final class ReportDailyCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = ReportDailyViewModel()
        let controller = ReportDailyViewController(viewModel: viewModel, coordinator: self)
        controller.popAction = popAction
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func popAction() {
        configuration.navigationController?.popViewController(animated: true)
    }
}
