//
//  AddJobView.swift
//  BarberVip
//
//  Created by Renilson Moreira on 26/08/22.
//

import UIKit

class AddJobView: UIView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem vindo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
extension AddJobView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel
            .topAnchor(in: self, attribute: .top, padding: 30)
            .leftAnchor(in: self, attribute: .left, padding: 20)
    }
    
    func setupConfiguration() {
        backgroundColor = .darkGray
    }
}
