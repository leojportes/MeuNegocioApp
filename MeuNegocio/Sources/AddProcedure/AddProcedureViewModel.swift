//
//  AddProcedureViewModel.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 30/08/22.
//

import UIKit

protocol AddProcedureViewModelProtocol {
    func createProcedure(procedure: CreateProcedureModel, completion: @escaping (Bool) -> Void)
    func closed()
}

class AddProcedureViewModel: AddProcedureViewModelProtocol {

    // MARK: - Properties
    private var coordinator: AddProcedureCoordinator?

    // MARK: - Init
    init(coordinator: AddProcedureCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: - Routes
    func closed() {
        coordinator?.closed()
    }

    // MARK: - Methods
    func createProcedure(procedure: CreateProcedureModel, completion: @escaping (Bool) -> Void) {
        
        let createProcedure = MNUserDefaults.getRemoteConfig()?.addProcedure ?? "http://54.86.122.10:3000/procedure"
        
        guard let url = URL(string: createProcedure) else {
            print("Error: cannot create URL")
            return
        }

        /// Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(procedure) else {
            print("Error: Trying to convert model to JSON data")
            return
        }

        /// Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(false)
                return
            }
           
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                completion(false)
                return
            }
            DispatchQueue.main.async {
                completion(true)
            }
        }.resume()
    }
}
