//
//  AddJobViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 30/08/22.
//

protocol AddJobViewModelProtocol {
    func addJob(data: AddJobModel)
    func closed()
}

class AddJobViewModel: AddJobViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: AddJobCoordinator?
    
    // MARK: - Init
    init(coordinator: AddJobCoordinator?) {
        self.coordinator = coordinator
    }
    
    func addJob(data: AddJobModel) {
        print(data)
    }
    
    // MARK: - Routes
    func closed() {
        coordinator?.closed()
    }
}
