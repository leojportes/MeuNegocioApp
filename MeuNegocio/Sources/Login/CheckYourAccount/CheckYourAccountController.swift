//
//  CheckYourAccountController.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 06/10/22.
//

import FirebaseAuth
import UIKit

class CheckYourAccountController: CoordinatedViewController {
    
    // MARK: - Private properties
    private lazy var customView = CheckYourAccountView(didTapVerifiedButton: weakify { $0.sendVerificationMail() } )

    private let viewModel: CheckYourAccountViewModelProtocol
    
    init(viewModel: CheckYourAccountViewModelProtocol, coordinator: CoordinatorProtocol){
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
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.barTintColor = .BarberColors.lightBrown
        self.view = customView
    }

    private var authUser : User? {
        return Auth.auth().currentUser
    }

    public func sendVerificationMail() {
        if self.authUser != nil && Current.shared.isEmailVerified.not {
            self.authUser!.sendEmailVerification() { (error) in
                self.showAlert(
                    title: "Atenção!",
                    messsage: "Foi enviado para seu email um link para verificar a sua conta.\n Verifique sua caixa de spam."
                )
            }
        } else { self.showAlert() }
        self.customView.verifiedEmailButton.loadingIndicator(show: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIViewController.findCurrentController()?.viewWillAppear(true)
    }
}
