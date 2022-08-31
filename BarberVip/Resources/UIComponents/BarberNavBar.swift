//
//  BarberNavBar.swift
//  BarberVip
//
//  Created by Leonardo Portes on 12/02/22.
//

import UIKit

final class BarberNavBar: UIView, ViewCodeContract {
    
    // MARK: - Private properties
    private var actionButton: Action?
    
    // MARK: - Init
    override func layoutSubviews() {
        setupView()
    }
    
    init(backgroundColor: UIColor? = nil,
         backgroundColorButtonLeft: UIColor? = nil,
         colorHorizontalLine: UIColor? = nil,
         iconLeft: UIImage? = nil,
         heightIcon: CGFloat,
         widhtIcon: CGFloat,
         backButtonAction: @escaping Action) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.actionButton = backButtonAction
        self.horizontalLine.backgroundColor = colorHorizontalLine

        self.barbersButton.setup(image: iconLeft,
                                 backgroundColor: backgroundColorButtonLeft ?? .white,
                                 action: backButtonAction)
        barbersButton.setIcon(height: heightIcon, width: widhtIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    private lazy var barbersButton: IconButton = {
        let button = IconButton()
        button.roundCorners(cornerRadius: 20, all: true)
        button.backgroundColor = UIColor.BarberColors.lightBrown
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var horizontalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Methods viewcode
    func setupHierarchy() {
        self.addSubview(barbersButton)
        self.addSubview(titleLabel)
        self.addSubview(horizontalLine)
    }
    
    func setupConstraints() {
        barbersButton
            .leftAnchor(in: self, padding: 10)
            .centerY(in: self)
            .heightAnchor(40)
            .widthAnchor(40)
        
        titleLabel
            .leftAnchor(in: barbersButton, attribute: .right, padding: 15)
            .centerY(in: barbersButton)
        
        horizontalLine
            .bottomAnchor(in: self, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(1)
    }
    
    // MARK: - Methods setup
    func set(title: String,
             color: UIColor? = nil,
             font: UIFont? = nil) {
        self.titleLabel.text = title
        self.titleLabel.textColor = color
        self.titleLabel.text = title
        self.titleLabel.font = font
    }
    
    // MARK: - Actions private methods
    private func didTapBack() {
        self.actionButton?()
    }
    
}
