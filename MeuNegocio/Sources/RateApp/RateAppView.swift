//
//  RateAppView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 19/12/22.
//

import Foundation
import UIKit

enum EmojiType: String {
    case bad = "Ruim"
    case good = "Boa"
    case regular = "Regular"
    case great = "Excelente"
}

protocol ActionRateAppProtocol: AnyObject {
    func typeEmojiSelected(type: EmojiType)
    func close()
}

final class RateAppView: UIView {
    
    // MARK: Properties
    weak var delegate: ActionRateAppProtocol?
    
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
        container.backgroundColor = .MNColors.grayRateApp
        container.layer.cornerRadius = 15
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.3
        container.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        container.layer.shadowRadius = 2
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var emojiBad: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: .bad)
        emoji.setup(action: { self.didTapEmoji(.bad) })
        return emoji
    }()
    
    lazy var emojiRegular: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: .regular)
        emoji.setup(action: { self.didTapEmoji(.regular) })
        return emoji
    }()
    
    lazy var emojiGood: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: .good)
        emoji.setup(action: { self.didTapEmoji(.good) })
        return emoji
    }()
    
    lazy var emojiGreat: EmojiView = {
        let emoji = EmojiView(image: "emoji_bad", title: .great)
        emoji.setup(action: { self.didTapEmoji(.great) })
        return emoji
    }()
    
    // MARK: Actions
    @objc func didTapClose() {
        delegate?.close()
    }
    
    func didTapEmoji(_ name: EmojiType) {
        delegate?.typeEmojiSelected(type: name)
    }
}

extension RateAppView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(container)
        container.addSubview(closedButton)
        container.addSubview(titleLabel)
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(emojiBad)
        stackView.addArrangedSubview(emojiRegular)
        stackView.addArrangedSubview(emojiGood)
        stackView.addArrangedSubview(emojiGreat)
    }
    
    func setupConstraints() {
    
        container
            .centerX(in: self)
            .centerY(in: self)
            .heightAnchor(170)
            .widthAnchor(300)
        
        closedButton
            .centerY(in: titleLabel)
            .rightAnchor(in: container, padding: 20)
            .widthAnchor(16)
            .heightAnchor(16)
        
        titleLabel
            .topAnchor(in: container, padding: 16)
            .leftAnchor(in: stackView, attribute: .left)
            .rightAnchor(in: stackView, attribute: .right)
        
        stackView
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 16)
            .bottomAnchor(in: container, padding: 24)
            .centerX(in: container)
        
    }
    
    func setupConfiguration() {
       backgroundColor = .clear
    }
}
