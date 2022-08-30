//
//  AddJobViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 30/08/22.
//

protocol AddJobViewModelProtocol {
    func addJob(data: AddJobModel)
}

class AddJobViewModel: AddJobViewModelProtocol {
    func addJob(data: AddJobModel) {
        print(data)
    }
}
