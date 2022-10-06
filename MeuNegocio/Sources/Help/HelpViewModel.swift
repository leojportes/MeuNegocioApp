//
//  HelpViewModel.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 04/09/22.
//

import Foundation

protocol HelpViewModelProtocol {
    func openWhatsapp()
}

class HelpViewModel: HelpViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: HelpCoordinator?
    
    // MARK: - Init
    init(coordinator: HelpCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: - Routes

    func openWhatsapp() {
        Current.shared.openWhatsapp(
            title: "Atenção!",
            messsage: "Você será redirecionado para o Whatsapp."
        )
    }
}
