//
//  ReportDailyViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation

final class ReportDailyViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var popAction: Action?
    
    // MARK: - Private properties
    private let customView = ReportView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
        setupCustomView()
    }
    
    // MARK: - Private methods
    private func setupCustomView() {
        customView.setupHomeView(title: "Relatório diário",
                                 popAction: { [weak self] in
                                    self?.popAction?()
                                 })
    }
}
