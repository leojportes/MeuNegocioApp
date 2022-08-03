//
//  LoginViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit

class LoginViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var navigateToHome: Action?
    
    // MARK: - Private properties
    private let customView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    // MARK: - Private methods
    private func setupView() {
        customView.setupHomeView(
        navigateToHome: { [weak self] in
            self?.navigateToHome?()
        })
    }
    
}
