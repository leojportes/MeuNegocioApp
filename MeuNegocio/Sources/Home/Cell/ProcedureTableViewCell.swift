//
//  ProcedureTableViewCell.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class ProcedureTableViewCell: UITableViewCell, ViewCodeContract {
    
    // MARK: - Static properties
    static let identifier = "ProcedureTableViewCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Viewcode
    private lazy var imagePoster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var procedureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "grayDescription")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(paymentTypeIcon)
        backView.addSubview(nameLabel)
        backView.addSubview(procedureLabel)
        backView.addSubview(priceLabel)
        backView.addSubview(paymentMethodLabel)
        backView.addSubview(separatorLine)
    }
    
    lazy var paymentTypeIcon = UIImageView() .. {
        $0.image = UIImage(named: "")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var separatorLine = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .MNColors.separatorGray
        $0.heightAnchor(1)
    }
    
    func setupConstraints() {
        contentView
            .topAnchor(in: self, padding: 5)
            .bottomAnchor(in: self, padding: 5)
        
        backView
            .topAnchor(in: contentView)
            .leftAnchor(in: contentView)
            .rightAnchor(in: contentView)
            .bottomAnchor(in: contentView)
    
        paymentTypeIcon
            .centerY(in: backView)
            .leftAnchor(in: backView, padding: 20)
            .widthAnchor(25)
            .heightAnchor(25)
        
        nameLabel
            .topAnchor(in: backView, padding: 20)
            .leftAnchor(in: paymentTypeIcon, attribute: .right, padding: 15)
            .widthAnchor(150)
        
        procedureLabel
            .topAnchor(in: nameLabel, attribute: .bottom, padding: 4)
            .leftAnchor(in: paymentTypeIcon, attribute: .right, padding: 15)
            .widthAnchor(130)
        
        priceLabel
            .topAnchor(in: backView, padding: 20)
            .leftAnchor(in: procedureLabel, attribute: .right, padding: 10)
            .rightAnchor(in: backView, padding: 20)
        
        paymentMethodLabel
            .topAnchor(in: priceLabel, attribute: .bottom, padding: 5)
            .rightAnchor(in: backView, padding: 20)
            .leftAnchor(in: procedureLabel, attribute: .right, padding: 5)
        
        separatorLine
            .topAnchor(in: paymentMethodLabel, attribute: .bottom, padding: 20)
            .rightAnchor(in: backView)
            .leftAnchor(in: backView)

    }
    
    func setupConfiguration() {
        selectionStyle = .none
    }
    
    // MARK: - Public methods
    func setupCustomCell(
        title: String? = nil,
        procedure: String? = nil,
        price: String? = nil,
        paymentMethod: String? = nil
    ) {
        nameLabel.text = title
        procedureLabel.text = procedure
        priceLabel.text = price
        paymentMethodLabel.text = paymentMethod
    }

    func setPaymentIcon(method: PaymentMethodType) {
        switch method {
        case .pix: paymentTypeIcon.image = UIImage(named: "ic_pix")
        case .cash: paymentTypeIcon.image = UIImage(named: "ic_cash")
        case .credit: paymentTypeIcon.image = UIImage(named: "ic_card")
        case .debit: paymentTypeIcon.image = UIImage(named: "ic_card")
        case .other: paymentTypeIcon.image = UIImage(named: "ic_cash") // WIP - Adicionar um ícone para .other
        }
    }
    
}
