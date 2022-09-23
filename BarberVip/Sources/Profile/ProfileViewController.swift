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
        didTapClose: weakify { $0.closedFlow() },
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
        setupCustomView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    func closedFlow() {
        viewModel.signOut { [ weak self ] result in
            result ? self?.viewModel.closedView() : self?.showAlert(
                title: "Ocorreu um erro",
                messsage: "Tente novamente mais tarde"
            )
        }
    }
    
    func setupCustomView() {
        guard let user = Auth.auth().currentUser?.email else { return }
        guard let isEmailVerified = Auth.auth().currentUser?.isEmailVerified else { return }
        customView.setup(profileEmail: user, isEmailVerified: isEmailVerified)
    }

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
