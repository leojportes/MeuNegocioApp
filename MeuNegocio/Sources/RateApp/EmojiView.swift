//
//  EmojiView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 20/12/22.
//

import UIKit

class EmojiView: TappedView {
    
    let emoji: EmojiType?
    
    init(emoji: EmojiType) {
        self.emoji = emoji
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
    
    lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureView() {
        switch emoji {
        case .bad:
            iconImage.image = UIImage(named: Icon.emojiBad.rawValue)
            titleLabel.text = "Ruim"
        case .regular:
            iconImage.image = UIImage(named: Icon.emojiRegular.rawValue)
            titleLabel.text = "Regular"
        case .good:
            iconImage.image = UIImage(named: Icon.emojiGood.rawValue)
            titleLabel.text = "Boa"
        case .great:
            iconImage.image = UIImage(named: Icon.emojiGreat.rawValue)
            titleLabel.text = "Excelente"
        default:
            break
        }
    }
}

extension EmojiView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(container)
        container.addSubview(iconImage)
        container.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        container
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self)
        
        iconImage
            .topAnchor(in: container)
            .leftAnchor(in: container)
            .rightAnchor(in: container)
            .heightAnchor(45)
            .widthAnchor(45)
        
        titleLabel
            .topAnchor(in: iconImage, attribute: .bottom, padding: 6)
            .bottomAnchor(in: container)
            .centerX(in: container)
    }
    
    func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    
}
