//
//  HomeCoordinator.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 07/02/22.
//

import Foundation

enum TypeScreen {
    case Report([GetProcedureModel])
    case Profile(UserModelList)
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
        case let .Report(procedures): openReport(procedures: procedures)
        case let .Profile(userData): openProfile(userData: userData)
        case .AddProcedure: openAddProcedure()
        case .Help: openHelp()
        case let .detailProcedure(procedure): detailProcedure(procedure: procedure)
        }
    }
}

extension HomeCoordinator {
    
    // MARK: - Routes
    private func openReport(procedures: [GetProcedureModel]) {
        ReportCoordinator(with: configuration).start(procedures: procedures)
    }

    private func openProfile(userData: UserModelList) {
        ProfileCoordinator(with: configuration).start(userData: userData)
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

