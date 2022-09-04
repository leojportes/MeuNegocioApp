//
//  ProfileViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/09/22.
//
import FirebaseAuth

protocol ProfileViewModelProtocol {
    func signOut(resultSignOut: (Bool) -> Void)
    func closedView()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: ProfileCoordinator?
    
    // MARK: - Init
    init(coordinator: ProfileCoordinator?) {
        self.coordinator = coordinator
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
    
    func closedView() {
        coordinator?.closed()
    }
}
