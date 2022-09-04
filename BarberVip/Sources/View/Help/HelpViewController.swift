//
//  HelpViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import UIKit
import MessageUI

class HelpViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private lazy var customView = HelpView(
        openMailCompose: weakify { $0.viewModel.openMailCompose() },
        openWhatsapp: weakify { $0.viewModel.openWhatsapp() }
    )

    private let viewModel: HelpViewModelProtocol
    
    // MARK: - Init
    init(viewModel: HelpViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ajuda"
    }

    override func loadView() {
        super.loadView()
        self.view = customView
    }

}
