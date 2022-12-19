//
//  RateAppView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 19/12/22.
//

import Foundation
import UIKit

final class RateAppView: UIView {
    
    // MARK: Properties
    
    var closureClose: Action?
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Code
    
    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .MNColors.darkGray
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var closedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Icon.closed.rawValue), for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Como está sua experiência \ncom o aplicativo?"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "emoji_bad")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    // MARK: Actions
    
    @objc func didTapClose() {
        closureClose?()
    }
    
    func configure(closureClose: @escaping Action) {
        self.closureClose = closureClose
    }
}

extension RateAppView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(container)
        container.addSubview(closedButton)
        container.addSubview(titleLabel)
    }
    
    func setupConstraints() {
    
        container
            .centerX(in: self)
            .centerY(in: self)
            .heightAnchor(150)
            .widthAnchor(300)
        
        closedButton
            .topAnchor(in: container, padding: 16)
            .rightAnchor(in: container, padding: 16)
            .widthAnchor(16)
            .heightAnchor(16)
        
        titleLabel
            .topAnchor(in: container, padding: 16)
            .leftAnchor(in: container, padding: 16)
        
    }
    
    func setupConfiguration() {
       backgroundColor = .clear
    }
    
}
