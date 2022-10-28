//
//  StartViewController.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 27/10/22.
//

import UIKit

class StartViewController: CoordinatedViewController {
    
    let customView = StartView()
    private let viewModel: StartViewModelProtocol
    
    init(viewModel: StartViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.validate()
    }
}
