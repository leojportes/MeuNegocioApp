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
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.navigationBar.tintColor = .MNColors.darkGray
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    func openEdit(procedure: GetProcedureModel) {
        print("PROCEDIMENTO A SER EDITADO: \(procedure)")
        AddProcedureCoordinator(with: configuration).start()
    }

}
