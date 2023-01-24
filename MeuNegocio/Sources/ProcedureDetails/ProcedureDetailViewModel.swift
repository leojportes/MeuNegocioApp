//
//  ProcedureDetailViewModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import Foundation

protocol ProcedureDetailViewModelProtocol: AnyObject {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
    func updateProcedure(_ procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel, Bool) -> Void)
}

class ProcedureDetailViewModel: ProcedureDetailViewModelProtocol {

    private let service: ProcedureDetailServiceProtocol

    // MARK: - Properties
    private var coordinator: ProcedureDetailCoordinator?

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

}
