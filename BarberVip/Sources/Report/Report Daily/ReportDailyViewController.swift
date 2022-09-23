//
//  ReportDailyViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation
import UIKit

final class ReportDailyViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var popAction: Action?
    
    // MARK: - Private properties
    private let customView = ReportView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "relatório diário"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        setupCustomView()
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    // MARK: - Private methods
    private func setupCustomView() {
        customView.setupHomeView(title: "Relatório diário",
                                 popAction: weakify { $0.popAction?() })
    }
}
