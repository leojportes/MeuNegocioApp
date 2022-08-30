//
//  AddJobViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit

class AddJobViewController: CoordinatedViewController {
    
    // MARK: - Properties
    private let customView = AddJobView()
    private let viewModel: AddJobViewModelProtocol
    var closedView: Action?
    
    init(viewModel: AddJobViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegateActions = self
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }

}

extension AddJobViewController: AddJobActionsProtocol {
    
    func addJob(nameClient: String, typeJob: String, typePayment: String, value: String) {
        customView.addButton.loadingIndicator(show: false)
        viewModel.addJob(data: AddJobModel(nameClient: nameClient,
                                           typeJob: typeJob,
                                           typePayment: typePayment,
                                           value: value))
        closedView?()
    }

    func alertEmptyField() {
        customView.addButton.loadingIndicator(show: false)
        showAlert(title: "atenção",
                  messsage: "preencha todos os campos")
    }
    
    
}
