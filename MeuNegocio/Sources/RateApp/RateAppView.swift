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
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .blue
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var emojiBad: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: "Ruim")
        return emoji
    }()
    
    lazy var emojiBad1: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: "Ruim")
        return emoji
    }()
    
    lazy var emojiBad2: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: "Ruim")
        return emoji
    }()
    
    lazy var emojiBad3: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: "Ruim")
        return emoji
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
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(emojiBad)
        stackView.addArrangedSubview(emojiBad1)
        stackView.addArrangedSubview(emojiBad2)
        stackView.addArrangedSubview(emojiBad3)
    }
    
    func setupConstraints() {
    
        container
            .centerX(in: self)
            .centerY(in: self)
            .heightAnchor(170)
            .widthAnchor(300)
        
        closedButton
            .topAnchor(in: container, padding: 20)
            .rightAnchor(in: container, padding: 20)
            .widthAnchor(16)
            .heightAnchor(16)
        
        titleLabel
            .topAnchor(in: container, padding: 24)
            .leftAnchor(in: stackView, attribute: .left)
        
        stackView
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 16)
            .centerX(in: container)
        
    }
    
    func setupConfiguration() {
       backgroundColor = .clear
    }
    
}


class EmojiView: UIView {
    
    let image: String?
    let title: String?
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: image ?? "")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension EmojiView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(iconImage)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        iconImage
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(45)
            .widthAnchor(45)
        
        titleLabel
            .topAnchor(in: iconImage, attribute: .bottom, padding: 4)
            .centerX(in: iconImage)
    }
    
    func setupConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .blue
    }
    
    
}
