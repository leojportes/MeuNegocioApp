//
//  ProcedureDetailViewModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import Foundation

protocol ProcedureDetailViewModelProtocol: AnyObject {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
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

}

protocol ProcedureDetailServiceProtocol {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
}

class ProcedureDetailService: ProcedureDetailServiceProtocol {

    /// Delete procedure
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "http://54.86.122.10:3000/procedure/\(procedure)") else {
            print("Error: cannot create URL")
            return
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
            completion(error?.localizedDescription ?? "Deletado com sucesso!")
        }.resume()
    }
}
