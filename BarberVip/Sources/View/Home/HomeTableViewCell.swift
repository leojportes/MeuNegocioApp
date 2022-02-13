//
//  HomeTableViewCell.swift
//  BarberVip
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class HomeTableViewCell: UITableViewCell, ViewCodeContract {
    
    // MARK: - Static properties
    static let identifier = "HomeTableViewCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(procedureLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(paymentMethodLabel)
    }
    
    func setupConstraints() {
        nameLabel
            .topAnchor(in: contentView, padding: 5)
            .leftAnchor(in: contentView, padding: 10)
            .bottomAnchor(in: contentView, padding: 5)
            .widthAnchor(70)
        
        procedureLabel
            .topAnchor(in: contentView, padding: 5)
            .leftAnchor(in: nameLabel, attribute: .right, padding: 25)
            .bottomAnchor(in: contentView, padding: 5)
            .widthAnchor(70)
        
        priceLabel
            .topAnchor(in: contentView, padding: 5)
            .leftAnchor(in: procedureLabel, attribute: .right, padding: 20)
            .bottomAnchor(in: contentView, padding: 5)
            .widthAnchor(70)
        
        paymentMethodLabel
            .topAnchor(in: contentView, padding: 5)
            .rightAnchor(in: contentView, padding: 10)
            .bottomAnchor(in: contentView, padding: 5)
            .widthAnchor(70)
        
    }
    
    func setupConfiguration() {
        selectionStyle = .none
        contentView.roundCorners(cornerRadius: 10, all: true)
        contentView.backgroundColor = UIColor.BarberColors.lightGray        
    }
    
    // MARK: - Public methods
    public func setupCustomCell(title: String? = nil,
                                procedure: String? = nil,
                                price: String? = nil,
                                paymentMethod: String? = nil) {
        nameLabel.text = title
        procedureLabel.text = procedure
        priceLabel.text = price
        paymentMethodLabel.text = paymentMethod
    }

}
