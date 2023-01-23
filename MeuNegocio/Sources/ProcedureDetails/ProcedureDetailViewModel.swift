//
//  ProcedureDetailViewModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import Foundation

protocol ProcedureDetailViewModelProtocol: AnyObject {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
    func updateProcedure(_ procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel) -> Void)
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
    
    func updateProcedure(_ procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel) -> Void) {
        service.updateProcedure(procedure: procedure) { result in
            completion(result)
        }
    }

}

protocol ProcedureDetailServiceProtocol {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
    func updateProcedure(procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel) -> Void)
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
    
    func updateProcedure(procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel) -> Void) {
        
        let updateModel = ProceduresToUpdateModel(nameClient: procedure.nameClient,
                                                  typeProcedure: procedure.typeProcedure,
                                                  formPayment: procedure.formPayment.rawValue,
                                                  value: procedure.value,
                                                  costs: procedure.costs.orEmpty)
        
        guard let url = URL(string: "http://54.86.122.10:3000/procedure/\(procedure._id)") else {
            print("Error: cannot create URL")
            return
        }

        /// Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(updateModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        /// Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UpdatedProceduresModel.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            catch {
                let error = error
                print(error)
            }


        }.resume()
    }
}
