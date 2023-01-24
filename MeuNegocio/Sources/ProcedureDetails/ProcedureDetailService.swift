//
//  ProcedureDetailService.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 23/01/23.
//

import Foundation

protocol ProcedureDetailServiceProtocol {
    func deleteProcedure(_ procedure: String, completion: @escaping (String) -> Void)
    func updateProcedure(procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel, Bool) -> Void)
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
    
    func updateProcedure(procedure: GetProcedureModel, completion: @escaping (UpdatedProceduresModel, Bool) -> Void) {
        
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
            
            guard let data = data else { return }

            guard error == nil else {
                DispatchQueue.main.async {
                    completion(UpdatedProceduresModel(), false)
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(UpdatedProceduresModel(), false)
                }
                return
            }
            
            do {
                let model = try JSONDecoder().decode(UpdatedProceduresModel.self, from: data)
                DispatchQueue.main.async {
                    completion(model, true)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(UpdatedProceduresModel(), false)
                }
            }


        }.resume()
    }
}
