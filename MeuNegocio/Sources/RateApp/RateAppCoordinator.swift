//
//  RateAppCoordinator.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 19/12/22.
//

import UIKit
import SafariServices

class RateAppCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = RateAppViewModel(coordinator: self)
        let controller = RateAppViewController(coordinator: self, viewModel: viewModel)
        configuration.viewController = controller
        controller.modalPresentationStyle = .custom
        controller.modalTransitionStyle = .crossDissolve
        configuration.navigationController?.present(controller, animated: false, completion: nil)
    }
    
    func close() {
        configuration.navigationController?.dismiss(animated: true)
    }
    
    func goToReview() {
        configuration.navigationController?.dismiss(animated: true, completion: {
            if let url = URL(string: "https://www.hackingwithswift.com") {
                UIApplication.shared.open(url)
            }
        })
    }
    
    func sendImprovementEmail() {
        print("enviar email")
    }
}