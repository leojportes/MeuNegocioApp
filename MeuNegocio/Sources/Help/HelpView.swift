//
//  HelpView.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 04/09/22.
//

import UIKit

final class HelpView: UIView {

    private var openMailCompose: Action?
    private var openWhatsapp: Action?

    // MARK: - Init

    init(
        openMailCompose: @escaping Action,
        openWhatsapp: @escaping Action
    ) {
        self.openMailCompose = openMailCompose
        self.openWhatsapp = openWhatsapp
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var emailButton = IconButton() .. {
        $0.setup(
            image: UIImage(named: Icon.email.rawValue),
            backgroundColor: .clear,
            action: weakify { $0.openMailCompose?() }
        )
    }

    private lazy var headerCardView = UIView() .. {
        $0.roundCorners(cornerRadius: 20)
        $0.backgroundColor = .BarberColors.yellowDark
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 1
    }

    private lazy var sendEmailButton = UIButton() .. {
        $0.setTitle("Tire sua dúvida por e-mail", for: .normal)
        $0.setTitleColor(.BarberColors.grayDarkest, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitleColor(.black, for: .highlighted)
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(didTapSendEmail), for: .touchUpInside)
    }

    private lazy var wppCardView = UIView() .. {
        $0.roundCorners(cornerRadius: 20)
        $0.backgroundColor = .BarberColors.yellowDark
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 1
    }

    private lazy var wppButton = UIButton() .. {
        $0.setTitle("Chame-nos no whatsapp", for: .normal)
        $0.setTitleColor(.BarberColors.grayDarkest, for: .normal)
        $0.setTitleColor(.darkGray, for: .highlighted)
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(didTapWpp), for: .touchUpInside)
    }

    private lazy var wppIconButton = IconButton() .. {
        $0.setup(
            image: UIImage(named: Icon.whatsapp.rawValue),
            backgroundColor: .clear,
            action: weakify { $0.openWhatsapp?() }
        )
    }
    
    // MARK: - Actions

    @objc
    private func didTapSendEmail() { openMailCompose?() }

    @objc
    private func didTapWpp() { openWhatsapp?() }

}

extension HelpView: ViewCodeContract {
 
    func setupHierarchy() {
        addSubview(headerCardView)
        addSubview(wppCardView)
        headerCardView.addSubview(emailButton)
        headerCardView.addSubview(sendEmailButton)
//        wppCardView.addSubview(wppIconButton)
//        wppCardView.addSubview(wppButton)
    }
    
    func setupConstraints() {
        headerCardView
            .topAnchor(in: self, padding: 50)
            .heightAnchor(60)
            .leftAnchor(in: self, padding: 15)
            .leftAnchor(in: self, padding: 15)
            .centerX(in: self)
        
        emailButton
            .centerY(in: headerCardView)
            .leftAnchor(in: headerCardView, padding: 15)
            .heightAnchor(35)
            .widthAnchor(35)
        
        sendEmailButton
            .centerY(in: emailButton)
            .leftAnchor(in: emailButton, attribute: .right, padding: 15)
            .rightAnchor(in: headerCardView, attribute: .right, padding: 15)
        
//        wppCardView
//            .topAnchor(in: headerCardView, attribute: .bottom, padding: 25)
//            .heightAnchor(60)
//            .leftAnchor(in: self, padding: 15)
//            .leftAnchor(in: self, padding: 15)
//            .centerX(in: self)

//        wppIconButton
//            .centerY(in: wppCardView)
//            .leftAnchor(in: wppCardView, padding: 15)
//            .heightAnchor(30)
//            .widthAnchor(30)
        
//        wppButton
//            .centerY(in: wppIconButton)
//            .leftAnchor(in: wppIconButton, attribute: .right, padding: 15)
//            .rightAnchor(in: wppCardView, attribute: .right, padding: 15)
//
    }
    
    func setupConfiguration() {
        backgroundColor = .BarberColors.lightBrown
    }
    
}
