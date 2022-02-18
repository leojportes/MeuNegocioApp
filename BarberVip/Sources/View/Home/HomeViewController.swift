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
        customView.setupHomeView(monthlyReportAction: { [weak self] in
                                    self?.navigateToMonthlyReport?()},
                                 dailyReportAction: { [weak self] in
                                    self?.navigateToDailyReport?()
                                 }, alertAction: { [weak self] in
                                    self?.show(title: "Funcionalidade não disponível!",
                                               messsage: "Estamos trabalhando nisso.") })
    }
    
    private func show(title: String, messsage: String) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel) { _ in
            let phoneNumber =  "48998308191"
            let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(appURL)
                }
            }
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
