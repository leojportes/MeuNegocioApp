//
//  HomeViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import Foundation

final class HomeViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var didTapNextFlow: Action?
    
    // MARK: - Private properties
    private let customView = HomeView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
        setupView()
    }
    
    // MARK: - Private methods
    private func setupView() {
        customView.setupHomeView(loginButtonAction: { [weak self] in
            self?.didTapNextFlow?()
        })
    }
}
