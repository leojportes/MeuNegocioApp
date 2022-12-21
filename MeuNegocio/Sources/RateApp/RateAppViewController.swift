//
//  RateAppViewController.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 19/12/22.
//

import Foundation
import UIKit
import MessageUI

class RateAppViewController: CoordinatedViewController {
    
    private let customView = RateAppView()
    private let viewModel: RateAppViewModelProtocol

    // MARK: - Init
    init(coordinator: CoordinatorProtocol, viewModel: RateAppViewModelProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    func sendEmailToInnovates() {
        let mailComposeController = MFMailComposeViewController() .. {
            $0.mailComposeDelegate = self
            $0.setToRecipients(["innovatestechsc@gmail.com"])
            $0.setSubject("Tenho uma dúvida")
            $0.setMessageBody("", isHTML: false)
            $0.modalPresentationStyle = .pageSheet
            $0.mailComposeDelegate = self
        }
        DispatchQueue.main.async {
            self.navigationController?.present(mailComposeController, animated: true)
        }
    }
}

extension RateAppViewController: ActionRateAppProtocol {
    func typeEmojiSelected(type: EmojiType) {
        MNUserDefaults.set(value: true, forKey: MNKeys.rateApp)
        switch type {
        case .great, .good, .regular:
            viewModel.goToReview()
        case .bad:
            dismiss(animated: true) {
                self.sendEmailToInnovates()
            }
        }
    }
    
    func close() {
        viewModel.close()
    }
}

// MARK: - MFMailComposeViewController Delegate
extension RateAppViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        /// You should switch the result only after dismissing the controller
        controller.dismiss(animated: true) {
            let message: String
            switch result {
            case .sent: message = "Mensagem enviada com sucesso!"
            case .saved: message = "Mensagem salva!"
            case .cancelled: message = "Mensagem cancelada!"
            case .failed:  message = "Erro desconhecido!"
            @unknown default: fatalError()
            }
            self.showAlert(title: "E-mail", messsage: message)
        }
    }
}
