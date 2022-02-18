//
//  ServiceBarberTableViewCell.swift
//  BarberVip
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class ServiceBarberTableViewCell: UITableViewCell, ViewCodeContract {
    
    // MARK: - Static properties
    static let identifier = "ServiceBarberTableViewCell"
    
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
        view.roundCorners(cornerRadius: 8)
        contentView.addShadow(color: UIColor.BarberColors.darkGray,
                              size: CGSize(width: -3,
                                           height: 3),
                              opacity: 0.4,
                              radius: 2.0)
        view.backgroundColor = UIColor.BarberColors.lightGray
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
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.BarberColors.darkGray
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var procedureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.BarberColors.darkGray
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.BarberColors.darkGray
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.BarberColors.darkGray
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(procedureLabel)
        backView.addSubview(priceLabel)
        backView.addSubview(paymentMethodLabel)
    }
    
    func setupConstraints() {
        contentView
            .topAnchor(in: self, padding: 10)
            .bottomAnchor(in: self, padding: 10)
        
        backView
            .topAnchor(in: contentView)
            .leftAnchor(in: contentView, padding: 8)
            .rightAnchor(in: contentView)
            .bottomAnchor(in: contentView)
        
        nameLabel
            .topAnchor(in: backView, padding: 5)
            .leftAnchor(in: backView, padding: 10)
            .bottomAnchor(in: backView, padding: 5)
            .widthAnchor(70)
        
        procedureLabel
            .topAnchor(in: backView, padding: 5)
            .leftAnchor(in: nameLabel, attribute: .right, padding: 25)
            .bottomAnchor(in: backView, padding: 5)
            .widthAnchor(70)
        
        priceLabel
            .topAnchor(in: backView, padding: 5)
            .leftAnchor(in: procedureLabel, attribute: .right, padding: 20)
            .bottomAnchor(in: backView, padding: 5)
            .widthAnchor(70)
        
        paymentMethodLabel
            .topAnchor(in: backView, padding: 5)
            .rightAnchor(in: backView, padding: 10)
            .bottomAnchor(in: backView, padding: 5)
            .widthAnchor(70)
    }
    
    func setupConfiguration() {
        selectionStyle = .none
    }
    
    // MARK: - Public methods
    func setupCustomCell(title: String? = nil,
                         procedure: String? = nil,
                         price: String? = nil,
                         paymentMethod: String? = nil) {
        nameLabel.text = title
        procedureLabel.text = procedure
        priceLabel.text = price
        paymentMethodLabel.text = paymentMethod
    }
    
}
