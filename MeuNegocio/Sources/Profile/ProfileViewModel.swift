//
//  ProfileViewModel.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 02/09/22.
//
import FirebaseAuth

protocol ProfileViewModelProtocol {
    func signOut(resultSignOut: (Bool) -> Void)
    func deleteDatabaseData(completion: @escaping (Bool) -> Void)
    func logout()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: ProfileCoordinator?
    private let user = Auth.auth().currentUser

    
    // MARK: - Init
    init(coordinator: ProfileCoordinator?) {
        self.coordinator = coordinator
    }
    
    func deleteDatabaseData(completion: @escaping (Bool) -> Void) {
        guard let email = Auth.auth().currentUser?.email else { return }
        guard let url = URL(string: "http://54.86.122.10:3000/procedure/delete-account/\(email)") else {
            print("Error: cannot create URL")
            return
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.user?.delete{ errorFirebase in
                            if error != nil {
                                print(errorFirebase?.localizedDescription)
                            } else {
                                print("Conta deletada com sucesso")
                                completion(true)
                            }
                        }
                    }
                } else {
                    completion(false)
                }
            }
   
        }.resume()
    }
    
    func signOut(resultSignOut: (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            resultSignOut(true)
        } catch {
            resultSignOut(false)
        }
    }
    
    // MARK: - Routes
    func logout() {
        KeychainService.deleteCredentials()
        coordinator?.closed()
    }
}
