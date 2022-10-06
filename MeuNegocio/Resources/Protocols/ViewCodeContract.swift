//
//  ViewCodeContract.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import Foundation

///Protocolo destinado a criação de views por código.
public protocol ViewCodeContract {
    
    /// Hierarquia de views
    func setupHierarchy()
    
    /// Ativação de constraints
    func setupConstraints()
    
    /// Configuração dos componentes
    func setupConfiguration()
}

public extension ViewCodeContract {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfiguration()
    }
    
    func setupConfiguration() {
        /* Default implementation */
    }
}
