//
//  RateAppViewController.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 19/12/22.
//

import Foundation
import UIKit

class RateAppViewController: CoordinatedViewController {
    
    let customView = RateAppView()
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
        closeView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    private func closeView() {
        customView.configure(closureClose: weakify { $0.viewModel.close() })
    }
}
