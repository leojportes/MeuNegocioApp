//
//  ProcedureDetailViewModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import Foundation

protocol ProcedureDetailViewModelProtocol: AnyObject {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
    func goToEditProcedure(_ procedure: GetProcedureModel)
    func updateProcedure(_ procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel, Bool) -> Void)
    func closed(_ type: Presentation)
    var coordinator: ProcedureDetailCoordinator? { get set }
}

class ProcedureDetailViewModel: ProcedureDetailViewModelProtocol {

    private let service: ProcedureDetailServiceProtocol

    // MARK: - Properties
    var coordinator: ProcedureDetailCoordinator?

    // MARK: - Init
    init(service: ProcedureDetailServiceProtocol = ProcedureDetailService(), coordinator: ProcedureDetailCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    internal func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void) {
        service.deleteProcedure(procedure) { message in
            completion(message)
        }
    }
    
    func updateProcedure(_ procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel, Bool) -> Void) {
        service.updateProcedure(procedure: procedure) { model, result in
            completion(model, result)
        }
    }
    
    func goToEditProcedure(_ procedure: GetProcedureModel) {
        coordinator?.routeEditProcedure(procedure)
    }
    
    func closed(_ type: Presentation) {
        coordinator?.closed(type)
    }
}
