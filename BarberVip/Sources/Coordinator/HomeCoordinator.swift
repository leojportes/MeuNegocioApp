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
        controller.navigateToMonthlyReport = navigateToReportView
        controller.navigateToDailyReport = navigateToReportDailyView
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.isHidden = true
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateToReportView() {
        let coordinator = ReportCoordinator(with: configuration)
        coordinator.start()
    }
    
    private func navigateToReportDailyView() {
        let coordinator = ReportDailyCoordinator(with: configuration)
        coordinator.start()
    }
    
}
