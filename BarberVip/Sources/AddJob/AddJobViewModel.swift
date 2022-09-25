//
//  AddJobViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 30/08/22.
//

import UIKit

protocol AddJobViewModelProtocol {
    func createProcedure(procedure: CreateProcedureModel, completion: @escaping (String) -> Void)
    func closed()
}

class AddJobViewModel: AddJobViewModelProtocol {

    // MARK: - Properties
    private var coordinator: AddJobCoordinator?

    // MARK: - Init
    init(coordinator: AddJobCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: - Routes
    func closed() {
        coordinator?.closed()
    }

    // MARK: - Methods
    func createProcedure(procedure: CreateProcedureModel, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "http://54.86.122.10:3000/procedure") else {
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
                completion("\(String(describing: error?.localizedDescription))")
                return
            }
           
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                completion("Error: HTTP request failed")
                return
            }
            DispatchQueue.main.async {
                completion("Procedimento cadastrado com sucesso!")
            }
        }.resume()
    }
}
