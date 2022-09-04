//
//  HomeCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import Foundation

enum TypeScreen {
    case MonthlyReport
    case ReportDaily
    case Profile
    case AddJob
    case Help
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
        case .MonthlyReport: openMonthlyReport()
        case .ReportDaily: openReportDaily()
        case .Profile: openProfile()
        case .AddJob: openAddJob()
        case .Help: openHelp()
        }
    }
}

extension HomeCoordinator {
    
    // MARK: - Routes

    private func openMonthlyReport() {
        MonthlyReportCoordinator(with: configuration).start()
    }

    private func openReportDaily() {
        ReportDailyCoordinator(with: configuration).start()
    }

    private func openProfile() {
        ProfileCoordinator(with: configuration).start()
    }

    private func openAddJob() {
        AddJobCoordinator(with: configuration).start()
    }

    private func openHelp() {
        HelpCoordinator(with: configuration).start()
    }
}

