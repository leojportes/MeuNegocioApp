//
//  HomeViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var navigateToMonthlyReport: Action?
    var navigateToDailyReport: Action?
    var navigateToProfile: Action?
    
    // MARK: - Private properties
    private let customView = HomeView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Private methods
    private func setupView() {
        customView.setupHomeView(monthlyReportAction: { [weak self] in
            self?.navigateToMonthlyReport?()},
                                 dailyReportAction: { [weak self] in
            self?.navigateToDailyReport?()
        }, alertAction: { [weak self] in
            self?.showAlert(title: "Funcionalidade não disponível!",
                       messsage: "Estamos trabalhando nisso.") },
                                 navigateToProfile: { [weak self] in
            self?.navigateToProfile?()
            
        })
    }
}
