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
    
    init(viewModel: AddJobViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastrar Procedimento"
        self.hideKeyboardWhenTappedAround()
        customView.delegateActions = self
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.barTintColor = .white
        self.view = customView
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIViewController.findCurrentController()?.viewWillAppear(true)
    }

}

extension AddJobViewController: AddJobActionsProtocol {
    
    func addJob(nameClient: String, typeJob: String, typePayment: String, value: String) {
        customView.addButton.loadingIndicator(show: true)
        viewModel.createProcedure(
            procedure: CreateProcedureModel(
                nameClient: nameClient,
                typeProcedure: typeJob,
                formPayment: typePayment,
                value: value
            )
        ) { result in
            DispatchQueue.main.async {
                self.customView.addButton.loadingIndicator(show: false)
                self.showAlert(title: String.stringEmpty, messsage: result)
            }
        }
    }

    func alertEmptyField() {
        customView.addButton.loadingIndicator(show: false)
        showAlert(title: "Atenção",
                  messsage: "Preencha todos os campos.")
    }
    
}
