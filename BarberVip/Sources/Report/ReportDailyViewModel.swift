//
//  ReportViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/09/22.
//

import Foundation

protocol ReportViewModelProtocol {
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void)
}

class ReportViewModel: ReportViewModelProtocol {
        
    let service = HomeService()
    
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void) {
        service.getProcedureList { result in
            completion(result)
        }
    }
}
