//
//  ForgetPasswordViewModel.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import Foundation
import FirebaseAuth

protocol ForgetPasswordViewModelProtocol {
    func resetPassFirebase(email: String)
}

class ForgetPasswordViewModel: ForgetPasswordViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: ForgetPasswordCoordinator?
    
    // MARK: - Init
    init(coordinator: ForgetPasswordCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: - Routes
    func resetPassFirebase(email: String) {
        let auth = Auth.auth()
        let currentController = UIViewController.findCurrentController()
        
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(email)
                currentController?.showAlert(
                    title: "Ops!",
                    messsage: error.localizedDescription
                )
                return
            }
            
            currentController?.showAlert(
                title: "Atenção",
                messsage: "Foi enviado um link para redefinir a sua senha no email mecionado.\n Verifique sua caixa de spam.",
                completion: { currentController?.dismiss(animated: true) })
        }
    }

}
