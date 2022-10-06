//
//  ErrorTableViewCell.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 26/09/22.
//

import UIKit

final class ErrorTableViewCell: UITableViewCell, ViewCodeContract {
    
    // MARK: - Static properties
    static let identifier = "ErrorTableViewCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var emptyView: ErrorView = {
        let view = ErrorView(title: "Sua lista está vazia!",
                             subTitle: "Arraste para atualizar ou adicione um novo procedimento.",
                             imageName: "icon-alert-error")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Viewcode

    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        contentView.addSubview(emptyView)
    }

    func setupConstraints() {
        emptyView
            .topAnchor(in: contentView, attribute: .top, padding: 40)
            .leftAnchor(in: contentView)
            .rightAnchor(in: contentView)
            .bottomAnchor(in: contentView)

    }
    
    func setupConfiguration() {
        selectionStyle = .none
    }
    
}

