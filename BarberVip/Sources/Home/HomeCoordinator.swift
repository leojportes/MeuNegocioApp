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
    case AddProcedure
    case Help
    case detailProcedure(GetProcedureModel)
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
        case .AddProcedure: openAddProcedure()
        case .Help: openHelp()
        case let .detailProcedure(procedure): detailProcedure(procedure: procedure)
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

    private func openAddProcedure() {
        AddProcedureCoordinator(with: configuration).start()
    }

    private func openHelp() {
        HelpCoordinator(with: configuration).start()
    }

    private func detailProcedure(procedure: GetProcedureModel) {
        let coordinator = ProcedureDetailCoordinator(with: configuration)
        coordinator.procedure = procedure
        coordinator.start()
    }
}

