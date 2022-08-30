//
//  AddJobViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit

class AddJobViewController: CoordinatedViewController {
    
    // MARK: - Properties
    let customView = AddJobView()

    var addJob: Action?
    var alertEmptyField: Action?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    // MARK: - Private methods
    func setupView() {
        customView.setupAddJobView(
            addJob: { [ weak self ] in
                self?.addJob?()
                self?.customView.addButton.loadingIndicator(show: false)
            },
            
            alertEmptyField: { [ weak self ] in
                self?.showAlert(title: "atenção",
                                messsage: "preencha todos os campos")
                self?.customView.addButton.loadingIndicator(show: false)
            })
    }

}
