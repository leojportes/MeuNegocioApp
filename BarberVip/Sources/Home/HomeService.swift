//
//  HomeService.swift
//  BarberVip
//
//  Created by Renilson Moreira on 30/09/22.
//
import Foundation
import FirebaseAuth


protocol HomeServiceProtocol {
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void)
    func deleteProcedure(_ procedure: String, completion: @escaping () -> Void)
    func fetchUser(completion: @escaping (UserModel) -> Void)
}

class HomeService: HomeServiceProtocol {

    // Get procedure list
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void) {
        guard let email = Auth.auth().currentUser?.email else { return }

        let urlString = "http://54.86.122.10:3000/procedure/\(email)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([GetProcedureModel].self, from: data)
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

    // Delete procedure
    func deleteProcedure(_ procedure: String, completion: @escaping () -> Void) {
        guard let url = URL(string: "http://54.86.122.10:3000/procedure/\(procedure)") else {
            print("Error: cannot create URL")
            return
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlReq) { _, _, _ in
            completion()
        }.resume()
    }
    
    func fetchUser(completion: @escaping (UserModel) -> Void) {
        guard let email = Auth.auth().currentUser?.email else { return }

        let urlString = "http://54.86.122.10:3000/profile/\(email)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(UserModel.self, from: data)
                completion(result)
            }
            catch {
                let error = error
                print(error)
            }
        }.resume()
    }
}
