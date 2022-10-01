//
//  ProfileViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/09/22.
//
import FirebaseAuth

protocol ProfileViewModelProtocol {
    func fetchUser(completion: @escaping (UserModelList) -> Void)
    func signOut(resultSignOut: (Bool) -> Void)
    func closedView()
    func logout()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: ProfileCoordinator?
    
    // MARK: - Init
    init(coordinator: ProfileCoordinator?) {
        self.coordinator = coordinator
    }
    
    func fetchUser(completion: @escaping (UserModelList) -> Void) {
        guard let email = Auth.auth().currentUser?.email else { return }

        let urlString = "http://54.86.122.10:3000/profile/\(email)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(UserModelList.self, from: data)
                completion(result)
            }
            catch {
                let error = error
                print(error)
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
    func closedView() {
        coordinator?.closedView()
    }
    
    func logout() {
        coordinator?.closed()
    }
}
