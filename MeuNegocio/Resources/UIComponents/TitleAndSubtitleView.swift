//
//  TitleAndSubtitleView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 28/12/22.
//

import Foundation
import UIKit

class TitleAndSubTitleView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var titleLabel = MNLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .MNColors.grayDarkest
        $0.textAlignment = .left
    }

    private lazy var subtitleLabel = MNLabel() .. {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .MNColors.grayDescription
        $0.numberOfLines = 0
        $0.textAlignment = .right
    }
    
    func configureView(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}

extension TitleAndSubTitleView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        container
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self)
        
        titleLabel
            .topAnchor(in: container, padding: 10)
            .leftAnchor(in: container)
            .bottomAnchor(in: container, padding: 10)
        
        subtitleLabel
            .topAnchor(in: container, padding: 10)
            .rightAnchor(in: container)
            .leftAnchor(in: container, padding: 120)
            .bottomAnchor(in: container, padding: 10)
        
    }
    
    func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addBottomBorder()
    }
    
}
