//
//  ProfileViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private lazy var customView = ProfileView(
        didTapLogout: weakify { $0.logout() },
        didTapClosedView: weakify { $0.closedView()},
        didTapVerifyEmail: weakify { $0.sendVerificationMail() }
    )

    private let viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Perfil"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUser()
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.barTintColor = .BarberColors.lightBrown
        self.view = customView
    }
    
    private func fetchUser() {
        viewModel.fetchUser { [ weak self ] user in
            DispatchQueue.main.async {
                self?.customView.user = user.first
            }
        }
    }
    
    private func closedView() {
        viewModel.closedView()
    }
    
    private func logout() {
        viewModel.signOut { [ weak self ] result in
            result ? self?.viewModel.logout() : self?.showAlert(
                title: "Ocorreu um erro",
                messsage: "Tente novamente mais tarde"
            )
        }
    }
    
//    func setupCustomView() {
//        guard let user = Auth.auth().currentUser?.email else { return }
//        customView.setup(user: "Renilson Moreira",
//                         email: user,
//                         barbershop: "Barbearia: Carminnati",
//                         city: "São jose/SC",
//                         isEmailVerified: isEmailVerified)
//    }

    private var authUser : User? {
        return Auth.auth().currentUser
    }

    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                self.showAlert(
                    title: "Atenção!",
                    messsage: "Foi enviado para seu email um link para verificar a sua conta.\n Verifique sua caixa de spam."
                )
            })
        } else { self.showAlert() }
    }
}
