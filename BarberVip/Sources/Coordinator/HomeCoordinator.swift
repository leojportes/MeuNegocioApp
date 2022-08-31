//
//  HomeCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import Foundation

enum TypeScreen {
    case MonthlyReport
    case DailyReport
    case Profile
    case AddJob
}

final class HomeCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let controller = HomeViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    func navigateTo(_ event: TypeScreen) {
        switch event {
        case .MonthlyReport:
            let coordinator = ReportCoordinator(with: configuration)
            coordinator.start()
        case .DailyReport:
            let coordinator = ReportDailyCoordinator(with: configuration)
            coordinator.start()
        case .Profile:
            let coordinator = ProfileCoordinator(with: configuration)
            coordinator.start()
        case .AddJob:
            let coordinator = AddJobCoordinator(with: configuration)
            coordinator.start()
        default:
            break
        }
    }
}
